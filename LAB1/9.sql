CREATE VIEW v1 AS 
SELECT DISTINCT customer.customer_id AS c
FROM customer 
JOIN rental A ON A.customer_id = customer.customer_id
JOIN rental B ON B.customer_id = customer.customer_id
WHERE A.staff_id < B.staff_id;

SELECT customer.first_name, customer.last_name
FROM customer
JOIN v1 ON customer.customer_id = v1.c;

DROP view v1