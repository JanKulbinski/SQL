CREATE TABLE Agenci (
licencja int(5),
nazwa varchar(90), 
wiek int,
typ enum('osoba indywidualna','agencja','inny'),
PRIMARY KEY (licencja)
);

CREATE TABLE Kontrakty (
ID int AUTO_INCREMENT,
agent int,
aktor smallint,
początek date,
koniec date,
gaża int,
PRIMARY KEY (ID),
FOREIGN KEY (agent) 
	REFERENCES Agenci(licencja)
	ON DELETE CASCADE,
FOREIGN KEY (aktor)
	REFERENCES aktorzy(aktor_id)
	ON DELETE CASCADE
); 

DELIMITER $$
CREATE TRIGGER wiek_before_insert BEFORE INSERT ON Agenci
FOR EACH ROW
BEGIN
	IF NEW.wiek < 21 THEN
    SET NEW.wiek = 21;
    END IF;
END; $$ 
DELIMITER ;

DELIMITER $$
CREATE TRIGGER wiek_before_update BEFORE UPDATE ON Agenci
FOR EACH ROW
BEGIN
	IF NEW.wiek < 21 THEN
    SET NEW.wiek = 21;
    END IF;
END; $$ 
DELIMITER ;

DELIMITER $$
CREATE TRIGGER gaża_before_insert BEFORE INSERT ON Kontrakty
FOR EACH ROW 
BEGIN
	IF NEW.gaża < 0 THEN
    SET NEW.gaża = 0;
	END IF;
    
    IF NEW.początek >= NEW.koniec THEN
    SET NEW.koniec = NEW.początek + 1;  
    END IF;
 ## zad 12   
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

DELIMITER $$
CREATE TRIGGER gaża_before_update BEFORE UPDATE ON Kontrakty
FOR EACH ROW 
BEGIN
	IF NEW.gaża < 0 THEN
    SET NEW.gaża = 0;
    END IF;
    
    IF NEW.początek >= NEW.koniec THEN
    SET NEW.koniec = NEW.początek + 1;
    END IF;
END; $$
DELIMITER ;