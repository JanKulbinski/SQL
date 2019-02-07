SELECT imie 		# uzywa indexow, where(leftmost prefix)
FROM aktorzy
WHERE imie LIKE 'J%';

SELECT nazwisko # nie uzywa, nie ma indeksu na liczbie filmow
FROM aktorzy
WHERE liczba_filmow >= 12; 

SELECT DISTINCT Z3.film_id as x # sposob bez widoku, uzywa, unikalny where
FROM aktorzy A
JOIN zagrali Z ON A.aktor_id = Z.aktor_id 
JOIN zagrali Z2 ON Z.film_id = Z2.film_id
JOIN zagrali Z3 ON Z3.aktor_id = Z2.aktor_id
WHERE A.imie = 'Zero' AND A.nazwisko = 'Cage';

CREATE VIEW v3 as # drugi sposob, z ladnym widokiem
SELECT A.aktor_id, Z.film_id, Z2.aktor_id as x
FROM aktorzy A
JOIN zagrali Z ON A.aktor_id = Z.aktor_id 
JOIN zagrali Z2 ON Z.film_id = Z2.film_id
WHERE A.imie = 'Zero' AND A.nazwisko = 'Cage';
SELECT DISTINCT Z.film_id # cd
FROM zagrali Z
JOIN v3 ON v3.x = Z.aktor_id;
DROP VIEW v3;

SELECT aktor # nie uzywa, bo roznice dat i tak trzeba policzyc dla kazdego wiersza,
FROM Kontrakty #a ona nie jest indeksowana 
JOIN (
	SELECT MIN(DATEDIFF(koniec,NOW())) AS r
    FROM Kontrakty
    WHERE DATEDIFF(koniec,NOW()) > 0 ) Tab1
WHERE Tab1.r = DATEDIFF(koniec,NOW());

SELECT imie FROM ( #uzywa
SELECT imie, Tab2.m, COUNT(aktor_id) as x
FROM aktorzy
JOIN (
	SELECT MAX(Tab.l) as m
	FROM (
		SELECT imie, (COUNT(aktor_id)) AS l
		FROM aktorzy
		GROUP BY imie ) Tab 
         ) Tab2
GROUP BY imie,Tab2.m
HAVING x = Tab2.m ) Tab3

# 'the index will be used if the assumped cost of using the index, and then 
# possibly having to perform futher bookmark lookups is lower than the cost of
# just scanning'
#
# indexes: uniq(few rows), not wide(lots of columns), where(leftmost prefix), group by, min 
