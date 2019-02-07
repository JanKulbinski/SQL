SELECT title
FROM film 
JOIN film_category ON film.film_id = film_category.film_id 
JOIN category ON film_category.category_id = category.category_id 
WHERE (description NOT LIKE '%Documentary%' AND category.name LIKE 'Documentary')