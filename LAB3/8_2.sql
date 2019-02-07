DELIMITER $$
CREATE TRIGGER pensja_after_update AFTER UPDATE ON Pracownicy
FOR EACH ROW
BEGIN

DECLARE nowa_war float(7,2);
DECLARE stara_war float(7,2);
DECLARE uzytkownik varchar(30);
DECLARE czas datetime;

SET uzytkownik = CURRENT_USER();
SET stara_war = OLD.pensja;
SET nowa_war =  NEW.pensja;

SET czas = CURRENT_TIMESTAMP();

INSERT INTO `LOGI`.logi 
VALUES(czas,uzytkownik,NEW.pensja,OLD.pensja);
END; $$
DELIMITER ;


