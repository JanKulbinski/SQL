CREATE DATABASE IF NOT EXISTS `Laboratorium-Filmoteka` ;


CREATE USER `244934`@`localhost`;
SET PASSWORD FOR `244934`@`localhost` = PASSWORD('jan934');

GRANT Select,Insert,Update ON `Laboratorium-Filmoteka`.* TO `244934`@`localhost`;
FLUSH PRIVILEGES;

