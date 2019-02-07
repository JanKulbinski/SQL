SELECT customer.first_name, customer.last_name
FROM customer
JOIN (
	SELECT customer.customer_id AS id, AVG(payment.amount) AS a
	FROM customer
	JOIN payment ON customer.customer_id = payment.customer_id
	GROUP BY customer.customer_id
	HAVING a > (
		SELECT AVG(payment.amount)
		FROM payment
		WHERE payment.payment_date LIKE '2005-07-07%'
	) 
) Tab1
ON customer.customer_id = Tab1.id