SELECT SUM(amount) AS total_revenue
FROM payment;
SELECT COUNT(*) AS total_customers
FROM customer;

SELECT title,
       replacement_cost,
       SQRT(replacement_cost) AS square_root_cost
FROM film;

SELECT title,
       rental_rate,
       POWER(rental_rate, 2) AS square_value
FROM film;

SELECT title,
       rental_rate,
       FLOOR(rental_rate) AS rounded_down
FROM film;

SELECT title,
       ROUND(replacement_cost / rental_duration, 2) AS rounded_cost
FROM film;
------------------------------------------------
------------------------------------------------
Date functions 

SELECT rental_id,
       rental_date,
       YEAR(rental_date) AS rental_year
FROM rental;

SELECT rental_id,
       rental_date,
       MONTH(rental_date) AS rental_month
FROM rental;

SELECT rental_id,
       rental_date,
       DAY(rental_date) AS rental_day
FROM rental;

SELECT rental_id,
       rental_date,
       MONTHNAME(rental_date) AS month_name
FROM rental;
---------------------------------------------
---------------------------------------------
SUBQUERY
 WHERE clause is used to filter data based on another query result.
 
 SELECT title, rental_rate
FROM film
WHERE rental_rate > (
    SELECT AVG(rental_rate)
    FROM film
);

SELECT title,
       rental_rate,
       (SELECT AVG(rental_rate) FROM film) AS average_rental_rate
FROM film;

SELECT avg_table.average_rate
FROM (
    SELECT AVG(rental_rate) AS average_rate
    FROM film
) AS avg_table;
Co-related Subquerys

SELECT title,
       rating,
       rental_rate
FROM film f1
WHERE rental_rate > (
    SELECT AVG(rental_rate)
    FROM film f2
    WHERE f1.rating = f2.rating
);
--------------------
--------------------
Bridge table
it is the link between two different tables

SELECT f.title,
       a.first_name,
       a.last_name
FROM film_actor fa
JOIN film f
    ON fa.film_id = f.film_id
JOIN actor a
    ON fa.actor_id = a.actor_id
WHERE f.title = 'ACADEMY DINOSAUR';



