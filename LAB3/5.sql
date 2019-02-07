DROP PROCEDURE ag;
DELIMITER $$
CREATE PROCEDURE ag (IN kol VARCHAR(30),IN agg VARCHAR(30),OUT X VARCHAR(30))
BEGIN
IF kol= 'PESEL' THEN SET kol = 'PESEL';
ELSEIF kol= 'imie' THEN SET kol = 'imie';
ELSEIF kol= 'nazwisko' THEN SET kol = 'nazwisko';
ELSEIF kol= 'data_urodzenia' THEN SET kol = 'data_urodzenia';
ELSEIF kol= 'wzrost' THEN SET kol = 'wzrost';
ELSEIF kol= 'waga' THEN SET kol = 'waga';
ELSEIF kol= 'rozmiar_buta' THEN SET kol = 'rozmiar_buta';
ELSEIF kol= 'ulubiony_kolor' THEN SET kol = 'ulubiony_kolor';
ELSE  SET kol = NULL;
END IF;

IF agg <>'MAX' AND agg <> 'MIN' AND agg <>'COUNT' AND agg <> 'SUMA' AND agg <> 'AVG'
	THEN SET agg = NULL; END IF;
    
SET @q= CONCAT("SELECT ", agg, "(", kol, ") INTO @X FROM Ludzie;");
PREPARE stmt FROM @q;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
SET X=@X;
END;$$
DELIMITER ;

CALL ag('wzrost','MAX',@X);
SELECT @X;
