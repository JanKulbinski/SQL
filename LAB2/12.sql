DELIMITER $$
CREATE TRIGGER after_kontrakt_insert AFTER INSERT ON Kontrakty
FOR EACH ROW
BEGIN
IF (NOT EXISTS (SELECT * FROM Agenci WHERE licencja = NEW.agent)) THEN
    INSERT INTO Agenci (nazwa,wiek,typ)
    VALUES(NEW.agent, 'Jacob',34,'agencja');    
END IF;

IF (EXISTS (
		SELECT * FROM Kontrakty
            WHERE NEW.aktor = aktor 
            AND NEW.początek < koniec )) THEN
	DELETE FROM Kontrakty 
    WHERE NEW.aktor = aktor 
    AND NEW.początek < koniec;
END IF;
END; $$

DELIMITER ;
