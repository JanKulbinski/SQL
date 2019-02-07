UPDATE language
JOIN film ON language.language_id = film.language_id
SET film.language_id = (
	SELECT language_id
	FROM language
	WHERE name = 'Mandarin'
)
WHERE film.title = 'WON DARES';

UPDATE language
JOIN film ON language.language_id = film.language_id
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
SET film.language_id = (
	SELECT language_id
	FROM language
	WHERE name = 'German'
) 
WHERE (actor.first_name = 'NICK' AND actor.last_name = 'WAHLBERG');


