DELIMITER $$
CREATE PROCEDURE stare_kontrakty()
BEGIN
DECLARE i INT DEFAULT 1;
DECLARE agent INT;
DECLARE poczatek DATE;
DECLARE koniec DATE;
DECLARE gaża INT;
DECLARE obecny_poczatek DATE DEFAULT '2014-02-23';
DECLARE id INT;
	WHILE i < 31 DO 
		SET id := (SELECT COUNT(*) FROM Kontrakty);
        SET id = id+1; 

        SET agent = FLOOR(RAND()*1000);
        SET gaża = FLOOR(RAND()*100000)+1000;
        
        SET koniec = DATE_SUB(obecny_poczatek, INTERVAL agent DAY);
		SET poczatek = DATE_SUB(koniec, INTERVAL agent DAY);

        INSERT INTO Kontrakty
        VALUES(id,agent,i,poczatek,koniec,gaża);
        SET i = i+1;
    END WHILE;    
END; $$
DELIMITER ;

CALL stare_kontrakty();

ALTER TABLE Kontrakty 
MODIFY COLUMN gaża INT(11) 
COMMENT"gaża podana w złotówkach/miesiąc";

#mysql -u -p 244934