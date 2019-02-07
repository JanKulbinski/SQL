CREATE DATABASE IF NOT EXISTS `Lab3` ;

CREATE TABLE `Ludzie` (
PESEL char(11) NOT NULL,
imie varchar(30),
nazwisko varchar(30),
data_urodzenia date,
wzrost float(3,2),
waga float(4,2),
rozmiar_buta int,
ulubiony_kolor enum('czarny', 'czerwony','zielony', 'niebieski','bialy'),
PRIMARY KEY(PESEL)
);

CREATE TABLE `Pracownicy` ( 
PESEL char(11),
zawod varchar(30),
pensja float(7,2),
FOREIGN KEY (PESEL)
	REFERENCES Ludzie(PESEL)
	ON DELETE CASCADE
); 


DELIMITER $$
CREATE TRIGGER ludzie_before_update BEFORE UPDATE ON Ludzie
FOR EACH ROW 
BEGIN

DECLARE y VARCHAR(2);
DECLARE m VARCHAR(2);
DECLARE d VARCHAR(2);
DECLARE dat DATE;
SET dat = NEW.data_urodzenia; 
SET y = SUBSTRING(NEW.PESEL,1,2);
SET m = SUBSTRING(NEW.PESEL,3,2);
SET d = SUBSTRING(NEW.PESEL,5,2);

IF ( NEW.PESEL NOT RLIKE '^[0-9]{11,11}$' OR y <> SUBSTRING(YEAR(dat),3,2) 
OR m <> MONTH(dat) OR d <> DAY(dat) ) THEN 
SIGNAL SQLSTATE '45000' SET message_text = 'zly format peselu';
END IF;

IF (NEW.wzrost < 0) then SET NEW.wzrost = (-1)*(wzrost); END IF;
IF (NEW.waga < 0) then SET NEW.waga = (-1)*(waga); END IF;
IF (NEW.rozmiar_buta < 0) then SET NEW.rozmiar_buta = (-1)*(rozmiar_buta); END IF;
END; $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER ludzie_before_insert BEFORE INSERT ON Ludzie
FOR EACH ROW 
BEGIN

DECLARE y VARCHAR(2);
DECLARE m VARCHAR(2);
DECLARE d VARCHAR(2);
DECLARE dat DATE;
SET dat = NEW.data_urodzenia; 
SET y = SUBSTRING(NEW.PESEL,1,2);
SET m = SUBSTRING(NEW.PESEL,3,2);
SET d = SUBSTRING(NEW.PESEL,5,2);

IF ( NEW.PESEL NOT RLIKE '^[0-9]{11,11}$' OR y <> SUBSTRING(YEAR(dat),3,2) 
OR m <> MONTH(dat) OR d <> DAY(dat) ) THEN 
SIGNAL SQLSTATE '45000' SET message_text = 'zly format peselu';
END IF;

IF (NEW.wzrost < 0) then SET NEW.wzrost = (-1)*(wzrost); END IF;
IF (NEW.waga < 0) then SET NEW.waga = (-1)*(waga); END IF;
IF (NEW.rozmiar_buta < 0) then SET NEW.rozmiar_buta = (-1)*(rozmiar_buta); END IF;

END; $$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER pracownicy_before_insert BEFORE INSERT ON Pracownicy
FOR EACH ROW 
BEGIN

DECLARE sal float;
DECLARE dat DATE;

SELECT data_urodzenia INTO dat FROM Ludzie WHERE PESEL = NEW.PESEL;
SELECT MIN(pensja) INTO sal FROM Pracownicy WHERE zawod = 'informatyk'; 
IF DATE(NOW()) <= DATE_ADD(dat, INTERVAL 18 YEAR) THEN
	SIGNAL SQLSTATE '45000' SET message_text = 'niepelnoletnia osoba';
END IF;

IF (NEW.pensja < 0) THEN
	SET NEW.pensja = (-1)*(pensja); END IF;

IF (NEW.zawod = 'sprzedawca' AND DATE(NOW()) >= DATE_ADD(dat, INTERVAL 65 YEAR)) THEN 
	SIGNAL SQLSTATE '45000' SET message_text = 'sprzedawca ma ponad 65 lat'; END IF;
    
IF(NEW.pensja > 3*sal) THEN 
	SET NEW.pensja = 3*sal;  END IF;

IF(sal > NEW.pensja) THEN 
	SET NEW.pensja = sal;
END IF;    
END; $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER pracownicy_before_update BEFORE UPDATE ON Pracownicy
FOR EACH ROW 
BEGIN
DECLARE sal float;
DECLARE dat DATE;
SELECT data_urodzenia INTO dat FROM Ludzie WHERE PESEL = NEW.PESEL;
SELECT MIN(pensja) INTO sal FROM Pracownicy WHERE zawod = 'informatyk'; 
IF DATE(NOW()) <= DATE_ADD(dat, INTERVAL 18 YEAR) THEN
SIGNAL SQLSTATE '45000' SET message_text = 'niepelnoletnia osoba'; END IF;

IF (NEW.pensja < 0) THEN
	SET NEW.pensja = (-1)*(pensja); END IF;

IF (NEW.zawod = 'sprzedawca' AND DATE(NOW()) >= DATE_ADD(dat, INTERVAL 65 YEAR)) THEN 
	SIGNAL SQLSTATE '45000' SET message_text = 'sprzedawca ma ponad 65 lat'; END IF;
    
IF(NEW.pensja > 3*sal) THEN 
	SET NEW.pensja = 3*sal;  END IF;
IF(sal > NEW.pensja) THEN 
	SET NEW.pensja = sal;
END IF;
END; $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE 200_people()
BEGIN

DECLARE i INT DEFAULT 0;
DECLARE start DATE DEFAULT '1930-05-20';

DECLARE PESEL char(11);
DECLARE imie varchar(30);
DECLARE nazwisko varchar(30);
DECLARE data_urodzenia date;
DECLARE wzrost float(3,2);
DECLARE waga float(4,2);
DECLARE rozmiar_buta int;
DECLARE ulubiony_kolor enum('czarny', 'czerwony','zielony', 'niebieski','bialy');
SET i = 0;
WHILE i < 200 DO
	SET start = DATE_ADD(start, INTERVAL 136 DAY);
    SET data_urodzenia = start;
    SET PESEL = CONCAT(DATE_FORMAT(data_urodzenia,'%y%m%d'),FLOOR(RAND() * 9999)+ 10000);
	SELECT l.imie INTO imie FROM `Laboratorium-Filmoteka`.aktorzy AS l WHERE aktor_id = i;
	SELECT l.nazwisko INTO nazwisko FROM `Laboratorium-Filmoteka`.aktorzy AS l WHERE aktor_id = i;
	SET wzrost = (RAND()*0.6)+1.4;
	SET waga = (RAND()*60)+39;
	SET rozmiar_buta = FLOOR((RAND()*15))+34;
	IF i%5 = 0 THEN SET ulubiony_kolor= 'czarny'; END IF; 
    IF i%5 = 1 THEN SET ulubiony_kolor= 'czerwony'; END IF;
	IF i%5 = 2 THEN SET ulubiony_kolor= 'zielony'; END IF;
    IF i%5 = 3 THEN SET ulubiony_kolor= 'niebieski'; END IF;
    IF i%5 = 4 THEN SET ulubiony_kolor= 'bialy'; END IF;
    SET i= i+1;
    INSERT INTO Ludzie VALUES (PESEL,imie,nazwisko,data_urodzenia,wzrost,waga,rozmiar_buta,ulubiony_kolor);
END WHILE;
END; $$
DELIMITER ;
CALL 200_people();

DELIMITER $$
CREATE PROCEDURE 175_employee()
BEGIN
DECLARE i INT DEFAULT 15;
DECLARE PESEL char(11);
DECLARE pensja float(7,2);
WHILE i < 190 DO
	SELECT l.PESEL INTO PESEL FROM Ludzie AS l LIMIT i,1; 
	SET pensja = (RAND() * 10000)+ 2000;
	IF i<65 THEN INSERT INTO Pracownicy VALUES(PESEL,'aktor',pensja);  
    ELSEIF i<98 THEN INSERT INTO Pracownicy VALUES(PESEL,'agent',pensja); 
	ELSEIF i<111 THEN INSERT INTO Pracownicy VALUES(PESEL,'informatyk',pensja); 
    ELSEIF i<113 THEN INSERT INTO Pracownicy VALUES(PESEL,'reporter',pensja); 
    ELSEIF i<190 THEN INSERT INTO Pracownicy VALUES(PESEL,'sprzedawca',pensja); END IF;
    SET i = i + 1;    
END WHILE;
END;$$
CALL 175_employee();