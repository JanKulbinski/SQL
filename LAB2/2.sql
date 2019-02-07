CREATE TABLE aktorzy(
	aktor_id smallint(5) NOT NULL AUTO_INCREMENT,
	imie varchar(45) NOT NULL,
	nazwisko varchar(45) NOT NULL,
	PRIMARY KEY(aktor_id)
);

CREATE TABLE filmy(
	film_id smallint(5) NOT NULL AUTO_INCREMENT,
    tytul varchar(255) NOT NULL,
    gatunek varchar(25) NOT NULL,
    czas smallint NOT NULL,
    kategoria_wiekowa enum ('R','PG-13','PG','NC-17','G') NOT NULL,
    PRIMARY KEY (film_id)
);

CREATE TABLE zagrali(
	film_id smallint(5),
	aktor_id smallint(5),
	CONSTRAINT fk_film FOREIGN KEY(film_id)
	  REFERENCES filmy(film_id)
      ON DELETE CASCADE,
	CONSTRAINT fk_aktor FOREIGN KEY(aktor_id)
      REFERENCES aktorzy(aktor_id)
      ON DELETE CASCADE
);

INSERT INTO `Laboratorium-Filmoteka`.filmy
SELECT f.film_id, title, c.name, length, rating
FROM sakila.film AS f
JOIN sakila.film_category AS fc ON f.film_id = fc.film_id
JOIN sakila.category AS c ON fc.category_id = c.category_id
WHERE title NOT LIKE '*x*' AND title NOT LIKE '*v*';

INSERT INTO `Laboratorium-Filmoteka`.aktorzy
SELECT actor_id, first_name, last_name FROM sakila.actor AS a
WHERE a.first_name NOT LIKE '*x*' AND a.last_name NOT LIKE '*v*';

INSERT INTO `Laboratorium-Filmoteka`.zagrali 
SELECT a.film_id, a.actor_id  FROM sakila.film_actor AS a;