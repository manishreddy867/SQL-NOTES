SELECT *
FROM customer
WHERE first_name LIKE 'J%'
  AND active = 1;
  ----------------------------------------
  SELECT *
FROM film
WHERE title LIKE '%ACTION%'
   OR description LIKE '%WAR%';
   ------------------------------------------
   SELECT *
FROM customer
WHERE last_name <> 'SMITH'
  AND first_name LIKE '%a';
  -------------------------------------------
  SELECT *
FROM film
WHERE rental_rate > 3.0
  AND replacement_cost IS NOT NULL;
  ----------------------------------------------
  SELECT store_id,
       COUNT(*) AS active_customers
FROM customer
WHERE active = 1
GROUP BY store_id;
---------------------------------------------------
SELECT DISTINCT rating
FROM film;
---------------------------------------------------
SELECT rental_duration,
       COUNT(*) AS film_count,
       AVG(length) AS avg_length
FROM film
GROUP BY rental_duration
HAVING AVG(length) > 100;
----------------------------------------------------
SELECT DATE(payment_date) AS payment_day,
       SUM(amount) AS total_paid,
       COUNT(*) AS payment_count
FROM payment
GROUP BY DATE(payment_date)
HAVING COUNT(*) > 100;
-------------------------------------------------------
SELECT *
FROM customer
WHERE email IS NULL
   OR email LIKE '%.org';
------------------------------------------------------
SELECT *
FROM film
WHERE rating IN ('PG', 'G')
ORDER BY rental_rate DESC;
-----------------------------------------------------
SELECT length,
       COUNT(*) AS film_count
FROM film
WHERE title LIKE 'T%'
GROUP BY length
HAVING COUNT(*) > 5;
------------------------------------------------------
SELECT a.actor_id,
       a.first_name,
       a.last_name,
       COUNT(fa.film_id) AS film_count
FROM actor a
JOIN film_actor fa
    ON a.actor_id = fa.actor_id
GROUP BY a.actor_id,
         a.first_name,
         a.last_name
HAVING COUNT(fa.film_id) > 10;
-----------------------------------------------------
SELECT title,
       rental_rate,
       length
FROM film
ORDER BY rental_rate DESC,
         length DESC
LIMIT 5;
------------------------------------------------------
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       COUNT(r.rental_id) AS total_rentals
FROM customer c
LEFT JOIN rental r
       ON c.customer_id = r.customer_id
GROUP BY c.customer_id,
         c.first_name,
         c.last_name
ORDER BY total_rentals DESC;
-----------------------------------------------------
SELECT f.title
FROM film f
LEFT JOIN inventory i
       ON f.film_id = i.film_id
LEFT JOIN rental r
       ON i.inventory_id = r.inventory_id
WHERE r.rental_id IS NULL;
--------------------------------------------------------

