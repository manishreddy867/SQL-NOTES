#Joins 
#INNER JOIN

SELECT f.title, l.name AS language
FROM sakila.film f
INNER JOIN sakila.language l ON f.language_id = l.language_id;

-- SELECT f.title, l.name AS language
-- FROM sakila.film f
-- INNER JOIN sakila.language l ON f.language_id = l.language_id;

-------------------------------------------------

#LEFT JOIN

SELECT f.title, c.name AS category
FROM sakila.film f
LEFT JOIN sakila.film_category fc ON f.film_id = fc.film_id
LEFT JOIN sakila.category c ON fc.category_id = c.category_id;

SELECT c.customer_id, c.first_name, r.rental_id
FROM sakila.customer c
LEFT JOIN sakila.rental r ON c.customer_id = r.customer_id;
-------------

-----------------------
-----------
#fullouter join 
# List all actors and the films they’ve acted in (even if unmatched on either side

SELECT a.actor_id, a.first_name, fa.film_id
FROM sakila.actor a
LEFT JOIN sakila.film_actor fa ON a.actor_id = fa.actor_id

UNION

SELECT a.actor_id, a.first_name, fa.film_id
FROM sakila.actor a
RIGHT JOIN sakila.film_actor fa ON a.actor_id = fa.actor_id;

------------------------
#  List all customers and all rentals, including those without each other

SELECT c.customer_id, r.rental_id
FROM sakila.customer c
LEFT JOIN sakila.rental r ON c.customer_id = r.customer_id

UNION

SELECT c.customer_id, r.rental_id
FROM sakila.customer c
RIGHT JOIN sakila.rental r ON c.customer_id = r.customer_id;

-------------------------------

#SELF JOIN

SELECT s1.staff_id, s2.staff_id, s1.store_id
FROM sakila.staff s1
JOIN sakila.staff s2 ON s1.store_id = s2.store_id
WHERE s1.staff_id <> s2.staff_id;
  


#CTE
-- A CTE (Common Table Expression) is a temporary result set that you can reference within a SELECT, INSERT, UPDATE, or DELETE query.
-- readable , re usable

SELECT customer_id, total_payments
FROM (
    SELECT customer_id, COUNT(*) AS total_payments
    FROM sakila.payment
    GROUP BY customer_id
) AS sub
WHERE total_payments > 5
;

----------------
WITH payment_counts AS (
    SELECT customer_id, COUNT(*) AS total_payments
    FROM sakila.payment
    GROUP BY customer_id
)
SELECT customer_id, total_payments
FROM payment_counts
WHERE total_payments > 5;


WITH payment_counts AS (
    SELECT customer_id, COUNT(*) AS total_payments
    FROM sakila.payment
    GROUP BY customer_id
)
SELECT c.customer_id, c.first_name, c.last_name, p.total_payments
FROM sakila.customer c
JOIN payment_counts p ON c.customer_id = p.customer_id
WHERE p.total_payments > 5;


--------------------------------------------------------------------
WITH total_payments AS (
    SELECT customer_id, SUM(amount) AS total_amount
    FROM sakila.payment
    GROUP BY customer_id
),
latest_payment AS (
    SELECT customer_id, MAX(payment_date) AS last_payment_date
    FROM sakila.payment
    GROUP BY customer_id
)
SELECT c.customer_id, c.first_name, c.last_name,
       tp.total_amount,
       lp.last_payment_date
FROM sakila.customer c
LEFT JOIN total_payments tp ON c.customer_id = tp.customer_id
LEFT JOIN latest_payment lp ON c.customer_id = lp.customer_id;

-----------

    
----------------------------------
WITH RECURSIVE numbers AS (
  -- Step 1: Anchor member (starting row)
  SELECT 1 AS n

  UNION ALL

  -- Step 2: Recursive member (generate next number)
  SELECT n + 1
  FROM numbers
  WHERE n < 20
) 
SELECT * FROM numbers;


------

-- Recursive CTE to generate the last 10 days
WITH RECURSIVE dates AS (
  SELECT DATE(MAX(rental_date)) - INTERVAL 9 DAY AS rental_day
  FROM sakila.rental
  UNION ALL
  SELECT rental_day + INTERVAL 1 DAY
  FROM dates
  WHERE rental_day + INTERVAL 1 DAY <= (SELECT MAX(rental_date) FROM sakila.rental)
)
SELECT d.rental_day, COUNT(r.rental_id) AS rentals
FROM dates d
LEFT JOIN sakila.rental r ON DATE(r.rental_date) = d.rental_day
GROUP BY d.rental_day;
