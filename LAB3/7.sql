
DELIMITER $$
CREATE PROCEDURE priv (kol VARCHAR(10),zaw VARCHAR(20))
BEGIN
SET @s = CONCAT("SELECT SUM(",kol,")+( (EXP((ABS(RAND()-0.05)/(MAX(",kol,")-MIN(",kol,")))) / (2*(MAX(",kol,")-MIN(",kol,")))))
FROM Ludzie L JOIN Pracownicy P ON L.PESEL = P.PESEL
WHERE zawod ='",zaw,"'");

PREPARE stms FROM @s;
EXECUTE stms;
END; $$

DELIMITER ;
CALL priv('waga','aktor');

