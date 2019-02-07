SELECT film.rating, COUNT(film.film_id)
FROM film
GROUP BY film.rating