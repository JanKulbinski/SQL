SELECT DISTINCT customer.first_name, customer.last_name, COUNT(DISTINCT rental.staff_id) AS s
FROM customer,rental
WHERE customer.customer_id = rental.customer_id 
GROUP BY customer.customer_id
HAVING s>=2