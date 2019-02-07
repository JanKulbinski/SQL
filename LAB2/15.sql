CREATE VIEW vAgenci AS
SELECT nazwa FROM Agenci;

CREATE VIEW vaktorzy AS 
SELECT imie, nazwisko FROM aktorzy;

CREATE VIEW vfilmy AS
SELECT tytul FROM filmy;

CREATE USER `15`@`localhost`;
SET PASSWORD FOR `15`@`localhost` = PASSWORD('123');

GRANT SELECT ON `Laboratorium-Filmoteka`.vAgenci TO `15`@`localhost`;
GRANT SELECT ON `Laboratorium-Filmoteka`.vfilmy TO `15`@`localhost`;
GRANT SELECT ON `Laboratorium-Filmoteka`.vaktorzy TO `15`@`localhost`;
FLUSH PRIVILEGES; 
#GRANT EXECUTE ANY PROCEDURE TO - procedure,functions
#	   delete,update,insert ON views- triggers 