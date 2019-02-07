
DELIMITER $$
CREATE TRIGGER after_zagrali_update AFTER UPDATE ON zagrali
FOR EACH ROW 
BEGIN 

DECLARE lf INT;

UPDATE aktorzy 
JOIN (
	SELECT a.aktor_id AS ac, COUNT(film_id) AS c
	FROM zagrali AS z
	RIGHT JOIN aktorzy AS a ON a.aktor_id = z.aktor_id
    WHERE a.aktor_id = OLD.aktor_id
	OR a.aktor_id = NEW.aktor_id
	GROUP BY ac ) Tab1
ON aktorzy.aktor_id = Tab1.ac
SET aktorzy.liczba_filmow = Tab1.c
WHERE aktorzy.aktor_id = OLD.aktor_id
OR aktorzy.aktor_id = NEW.aktor_id;
 
UPDATE aktorzy
JOIN (
	SELECT a.aktor_id AS ai, group_concat(f.tytul SEPARATOR ', ') as co
    FROM aktorzy AS a
    LEFT JOIN zagrali AS z 
    ON z.aktor_id = a.aktor_id
    JOIN filmy AS f 
    ON f.film_id = z.film_id
    WHERE a.aktor_id = OLD.aktor_id
	OR a.aktor_id = NEW.aktor_id
    GROUP BY ai ) Tab1
ON Tab1.ai = aktorzy.aktor_id
SET aktorzy.lista_filmow = Tab1.co
WHERE (aktorzy.aktor_id = OLD.aktor_id
OR aktorzy.aktor_id = NEW.aktor_id) AND aktorzy.liczba_filmow < 4;

SELECT liczba_filmow 
INTO lf
FROM aktorzy AS a
WHERE a.aktor_id = OLD.aktor_id;

IF lf = 0 THEN
UPDATE aktorzy 
SET lista_filmow=" " 
WHERE aktor_id = OLD.aktor_id;
END IF;

END;$$	
DELIMITER ;


DELIMITER $$

CREATE TRIGGER after_zagrali_delete AFTER DELETE ON zagrali
FOR EACH ROW 
BEGIN 

DECLARE lf INT;

UPDATE aktorzy
SET liczba_filmow = liczba_filmow-1
WHERE aktor_id = OLD.aktor_id;

UPDATE aktorzy
JOIN (
	SELECT a.aktor_id AS ai, group_concat(f.tytul SEPARATOR ', ') as co
    FROM aktorzy AS a
    LEFT JOIN zagrali AS z 
    ON z.aktor_id = a.aktor_id
    JOIN filmy AS f 
    ON f.film_id = z.film_id
    WHERE a.aktor_id = OLD.aktor_id
    GROUP BY ai ) Tab1
ON Tab1.ai = aktorzy.aktor_id
SET aktorzy.lista_filmow = Tab1.co
WHERE aktorzy.aktor_id = OLD.aktor_id AND aktorzy.liczba_filmow < 4;



SELECT liczba_filmow 
INTO lf
FROM aktorzy AS a
WHERE a.aktor_id = OLD.aktor_id;

IF lf = 0 THEN
UPDATE aktorzy 
SET lista_filmow=" " 
WHERE aktor_id = OLD.aktor_id;
END IF;

END; $$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER after_zagrali_insert AFTER INSERT ON zagrali
FOR EACH ROW 
BEGIN 

UPDATE aktorzy
SET liczba_filmow = liczba_filmow+1
WHERE aktor_id = NEW.aktor_id;

UPDATE aktorzy
JOIN (
	SELECT a.aktor_id AS ai, group_concat(f.tytul SEPARATOR ', ') as co
    FROM aktorzy AS a
    LEFT JOIN zagrali AS z 
    ON z.aktor_id = a.aktor_id
    JOIN filmy AS f 
    ON f.film_id = z.film_id
    WHERE a.aktor_id = NEW.aktor_id
    GROUP BY ai ) Tab1
ON Tab1.ai = aktorzy.aktor_id
SET aktorzy.lista_filmow = Tab1.co
WHERE aktorzy.aktor_id = NEW.aktor_id AND aktorzy.liczba_filmow < 4;

END;$$

DELIMITER ;


#TESTOWANIE
#INSERT INTO aktorzy VALUES (231,'x','y',0,"")
#INSERT INTO zagrali values(998,231), (997,231), (996,231);
#UPDATE zagrali SET film_id = '1' WHERE (film_id = 998 AND aktor_id = 231);
#delete from zagrali where film_id = 996 AND aktor_id = 231;
