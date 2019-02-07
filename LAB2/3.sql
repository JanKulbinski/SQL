ALTER TABLE aktorzy
ADD liczba_filmow smallint AFTER `nazwisko`,
ADD lista_filmow varchar(1026) AFTER `liczba_filmow`;

UPDATE aktorzy 
JOIN (
	SELECT a.aktor_id AS ac, COUNT(film_id) AS c
	FROM zagrali AS z
	RIGHT JOIN aktorzy AS a ON a.aktor_id = z.aktor_id 
	GROUP BY ac ) Tab1
ON aktorzy.aktor_id = Tab1.ac
SET aktorzy.liczba_filmow = Tab1.c
WHERE aktorzy.aktor_id <> 0; # using safe update mode 
							#-> can't update without 'where' with Key column 
UPDATE aktorzy
JOIN (
	SELECT a.aktor_id AS ai, group_concat(f.tytul SEPARATOR ', ') as co
    FROM aktorzy AS a
    LEFT JOIN zagrali AS z 
    ON z.aktor_id = a.aktor_id
    JOIN filmy AS f 
    ON f.film_id = z.film_id
    GROUP BY ai ) Tab1
ON Tab1.ai = aktorzy.aktor_id
SET aktorzy.lista_filmow = Tab1.co
WHERE aktorzy.aktor_id <> 0 AND aktorzy.liczba_filmow < 4;