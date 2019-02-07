SELECT film.title, film.length
FROM film
WHERE film.rating LIKE 'R'
ORDER BY film.length DESC
LIMIT 5
