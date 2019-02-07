CREATE VIEW v1 AS 
SELECT k.ID,k.agent,k.aktor,k.początek,k.koniec,k.gaża, DATEDIFF(k.koniec,k.początek) AS dlugosc,
k2.początek AS pocz,k2.koniec AS kon, DATEDIFF(k2.koniec,k2.początek) AS dlugosc2, k2.ID AS id2
FROM Kontrakty AS k
LEFT JOIN Kontrakty AS k2
ON k.agent = k2.agent AND k.aktor = k2.aktor AND k.koniec + 1 = k2.początek 
ORDER BY k.początek;


DELIMITER $$
CREATE PROCEDURE max_kontrakt ()
BEGIN
	DECLARE n INT DEFAULT 0;
    DECLARE i INT DEFAULT 0;
    DECLARE dl INT DEFAULT 0;
    DECLARE dl2 INT DEFAULT 0;
    DECLARE id INT DEFAULT 0;
    
    SET i = 0;
    SELECT COUNT(*) INTO n FROM Kontrakty ;
	
    WHILE (n > i) DO 
		SELECT v1.dlugosc, v1.dlugosc2, v1.id2
		INTO dl, dl2, id
		FROM v1
		LIMIT i,1;
		
        	UPDATE v1
		SET dlugosc = dl+dl2
		WHERE ID = id;
		SET i = i+1;
		END WHILE;
END;$$

DELIMITER ;



SELECT agent 
FROM v1
WHERE dlugosc = (
	SELECT MAX(dlugosc) 
	FROM v1);


DROP view v1;
DROP procedure max_kontrakt
