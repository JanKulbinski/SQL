SELECT customer.first_name, customer.last_name
FROM customer
JOIN (
	SELECT customer.customer_id AS id, Tab1.x, AVG(payment.amount) AS a
	FROM customer
	JOIN payment ON customer.customer_id = payment.customer_id
	JOIN (
		SELECT AVG(payment.amount) AS x
		FROM payment
		WHERE payment.payment_date LIKE '2005-07-07%'
		) Tab1
	GROUP BY customer.customer_id, Tab1.x
	HAVING a > Tab1.x 
	) Tab2
ON customer.customer_id = Tab2.id
