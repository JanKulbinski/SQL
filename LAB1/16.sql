SET SQL_SAFE_UPDATES = 0;

CREATE VIEW v1 AS
SELECT language.language_id AS id, COUNT(film.film_id) AS c
FROM language
LEFT JOIN film ON language.language_id = film.language_id
GROUP BY language.language_id;


ALTER TABLE language 
ADD films_no int AFTER language_id;


UPDATE language 
JOIN v1 ON v1.id = language.language_id
SET language.films_no = v1.c;


DROP VIEW v1