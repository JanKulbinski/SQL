CREATE VIEW v1 AS
SELECT imie, nazwisko, nazwa, DATEDIFF(koniec,NOW())
FROM aktorzy as a
JOIN Kontrakty as k ON a.aktor_id = aktor 
JOIN Agenci as ag ON agent = licencja
WHERE koniec > NOW();

#uzytkownik ma dostep, ale nie moze go stworzyc

#TEST
# mysql -u 244934 -p 
# jan934
# use Laboratorium-Filmoteka
# select view v1;