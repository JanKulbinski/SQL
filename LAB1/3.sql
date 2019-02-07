SELECT title, language.name
FROM film JOIN language ON film.language_id=language.language_id
WHERE description LIKE '%Documentary%'