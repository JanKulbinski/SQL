SELECT concat(E.first_name," ",E.last_name), concat(F.first_name," ",+F.last_name)
FROM (
	SELECT A.actor_id AS a, D.actor_id AS b, COUNT(B.film_id)
	FROM actor A
	JOIN film_actor B ON B.actor_id = A.actor_id 
	JOIN film_actor C ON B.film_id = C.film_id 
	JOIN actor D ON C.actor_id = D.actor_id
	WHERE D.actor_id > A.actor_id
	GROUP BY A.actor_id, D.actor_id
	HAVING COUNT(B.film_id)>=2
) Tab1
JOIN actor E ON E.actor_id = Tab1.a
JOIN actor F ON F.actor_id = Tab1.b
