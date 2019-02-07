SELECT film.title
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON rental.inventory_id = inventory.inventory_id
WHERE rental.rental_date BETWEEN '2005-05-25' AND '2005-05-30'
ORDER BY film.title