SELECT actor.first_name, actor.last_name
FROM actor
LEFT JOIN(
	SELECT DISTINCT film_actor.actor_id AS id
    	FROM film_actor
	JOIN film ON film.film_id = film_actor.film_id
    	WHERE film.title LIKE 'B%'
) Tab1
ON actor.actor_id = Tab1.id 
WHERE Tab1.id IS NULL
