SELECT K.country
FROM (
	SELECT country.country, COUNT(city.city_id)
	FROM country
    	JOIN city ON country.country_id = city.country_id
	GROUP BY country.country
    	HAVING COUNT(city.city_id)>= (
		SELECT COUNT(city.city_id) 
        	FROM country
        	JOIN city ON country.country_id = city.country_id
        	WHERE country.country = 'Canada' ) 
	) K
