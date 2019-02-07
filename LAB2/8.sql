DELIMITER $$
CREATE PROCEDURE srednia_gaza (licencja int)
BEGIN
    SELECT AVG(gaża)
    FROM Kontrakty AS k
    WHERE k.agent = licencja AND koniec > NOW();

END;$$

DELIMITER ;
CALL srednia_gaza(74)


