CREATE VIEW horror AS
SELECT actor.actor_id AS ac, COUNT(film_actor.film_id) AS m
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
JOIN film_category ON film_category.film_id = film.film_id
JOIN category ON category.category_id = film_category.category_id
WHERE category.name = 'Horror'
GROUP BY actor.actor_id;

CREATE VIEW actio AS
SELECT actor.actor_id AS ac, COUNT(film_actor.film_id) AS m
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
JOIN film_category ON film_category.film_id = film.film_id
JOIN category ON category.category_id = film_category.category_id
WHERE category.name = 'Action'
GROUP BY actor.actor_id;

SELECT actor.first_name,actor.last_name
FROM actor
LEFT JOIN horror ON horror.ac = actor.actor_id
LEFT JOIN actio ON actio.ac = actor.actor_id
WHERE ((actio.m < horror.m) OR (horror.m IS NOT NULL AND actio.m IS NULL));

DROP VIEW horror;
DROP VIEW actio