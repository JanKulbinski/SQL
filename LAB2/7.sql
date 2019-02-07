DELIMITER $$
CREATE PROCEDURE aktualny_agent(IN imie VARCHAR(45), IN nazwisko VARCHAR(45))
BEGIN 
	SELECT agent, DATEDIFF(koniec,początek) AS 'dni do konca kontraktu'
    FROM Kontrakty
    JOIN aktorzy on aktor = aktor_id
    WHERE aktorzy.imie = imie AND aktorzy.nazwisko = nazwisko AND koniec > NOW();
END;$$
DELIMITER ;

