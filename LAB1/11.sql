SELECT customer.first_name,customer.last_name
FROM customer
JOIN (
	SELECT customer.customer_id AS ID, COUNT(rental.rental_id) AS r
    FROM customer 
    JOIN rental ON customer.customer_id = rental.customer_id
    GROUP BY ID
    HAVING r> (
		SELECT COUNT(rental.rental_id)
		FROM customer 
		JOIN rental ON customer.customer_id = rental.customer_id
		WHERE customer.email= 'PETER.MENARD@sakilacustomer.org'
    )
) Tab1
ON customer.customer_id = Tab1.ID
