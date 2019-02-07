DROP PROCEDURE payday;

DELIMITER $$
CREATE PROCEDURE payday(IN budget INT(10),IN job VARCHAR(20) )
BEGIN
DECLARE s INT(10);

START TRANSACTION;


SELECT SUM(pensja) INTO s FROM Pracownicy WHERE zawod = job GROUP BY job;
IF s <= budget THEN 
SELECT CONCAT('********',SUBSTRING(PESEL,9,3),' wyplacono') AS PESEL
FROM Pracownicy
WHERE zawod = job;
END IF;

COMMIT;
END; $$

DELIMITER ;
CALL payday(100000,'reporter');