DELIMITER $$
CREATE PROCEDURE 1000agentow ()
BEGIN
DECLARE i INT DEFAULT 1;
DECLARE wiek SMALLINT;
DECLARE typz enum ('osoba indywidualna','agencja','inny') DEFAULT 'agencja';
	WHILE i < 999 DO
		SET wiek = FLOOR(RAND() * 80)+ 21;    
		INSERT INTO Agenci
		VALUES (i,"",wiek,'agencja');
        
        SET wiek = FLOOR(RAND() * 80)+ 21;
        INSERT INTO Agenci
        VALUES (i+1,"",wiek,'osoba indywidualna');
        
        SET wiek = FLOOR(RAND() * 80)+ 21;
        INSERT INTO Agenci
        VALUES (i+2,"",wiek,'inny');
        
        SET i = i+3;
    END WHILE;
END; $$
DELIMITER ;
CALL 1000agentow();

DELIMITER $$
CREATE PROCEDURE 200kontraktow ()
BEGIN
DECLARE i INT DEFAULT 1;
DECLARE agent INT;
DECLARE poczatek DATE;
DECLARE koniec DATE;
DECLARE gaża INT;
	WHILE i < 201 DO 
		SET agent = FLOOR(RAND()*1000);
        SET gaża = FLOOR(RAND()*100000)+1000;
		SET poczatek = DATE_SUB(NOW(), INTERVAL agent DAY);
        SET koniec = DATE_ADD(NOW(), INTERVAL agent DAY);
		INSERT INTO Kontrakty
        VALUES(i,agent,i,poczatek,koniec,gaża);
        SET i = i+1;
    END WHILE;    
END; $$
DELIMITER ;
CALL 200kontraktow();

UPDATE Agenci AS a
JOIN sakila.customer AS c
ON licencja = c.customer_id
SET a.nazwa = c.first_name
WHERE licencja <> 0 AND c.customer_id <> 0;

UPDATE Agenci AS a
JOIN sakila.customer AS c
ON licencja-599 = c.customer_id
SET a.nazwa = c.last_name
WHERE licencja > 599 AND c.customer_id <> 0;
