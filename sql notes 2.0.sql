session2.sql
#select 

 SELECT * FROM sakila.actor;
 
 SELECT DISTINCT first_name from sakila.actor;
 ----------
 select * from sakila.film where original_language_id is null;
 
 select count(*) from sakila.film ;
 --------------
select distinct title from sakila.film where original_language_id is  null;

------------------------------------------------
select count(distinct(title)) from sakila.film;
-------------------------------
#count and distinct count 

select count(first_name) from sakila.actor;
select count(distinct(first_name)) from sakila.actor;
-------------------
#select specific columns 

SELECT first_name,last_name FROM sakila.actor;
-------------------------------
#Limit 

SELECT first_name, last_name FROM sakila.actor limit 5;
--------------------
#filtering with where 

SELECT distinct(rating) FROM sakila.film;

SELECT * FROM sakila.film;

SELECT * FROM sakila.film WHERE rating = 'R'  and length >= 92;

SELECT * FROM sakila.film WHERE length >= 92;
------------------
#sorting 
SELECT rental_rate from sakila.film;

SELECT  rental_rate FROM sakila.film ORDER BY rental_rate desc;
--------------------
#AND #OR operators 

SELECT * FROM sakila.film 
where rating = 'PG' and rental_duration = 5
ORDER BY rental_rate ASC;

SELECT * FROM sakila.film 
where rating = 'PG' or rental_duration = 5
ORDER BY rental_rate ASC;


--------------------------------------
#NOT 

SELECT * FROM sakila.film 
where not rental_duration NOT IN ( 6, 7,3)
ORDER BY rental_rate ASC;

SELECT * FROM sakila.film 
where NOT rental_duration = 6 
ORDER BY rental_rate ASC;
-------------------------------------
SELECT * FROM sakila.film 
where rental_duration = 6 and (rating = 'G' OR rating = 'PG')
ORDER BY rental_rate ASC;


--------------------------------------------
#LIKE used with where clause 

-- There are two wildcards often used in conjunction with the LIKE operator:
-- 	The percent sign % represents zero, one, or multiple characters
-- 	The underscore sign _ represents one, single character

SELECT city FROM sakila.city where city like 'A%s'; #'A%s'

SELECT city FROM sakila.city where city like '_s___d%';
-----------------------------------------------------------------------
#NULL Value

#Check Rentals That Were Never Returned 

select * from sakila.rental;

SELECT rental_id, inventory_id, customer_id, return_date
FROM sakila.rental
WHERE return_date  IS  NULL;

-----------------------------------------
#between 

SELECT rental_id, inventory_id, customer_id, return_date
FROM sakila.rental
WHERE  return_date between '2005-05-26' and '2005-05-30';

------------------
#group by and having 
#TO CHECK DUPLICATES 

select  customer_id, COUNT(*) as count
FROM sakila.rental
GROUP BY customer_id
HAVING count(*)  <= 30 
order by  count desc;

-- select count(*) as count from sakila.rental;
-----------------------------------
#order of execution is SQL 

# from (table) ---> join ---> where --- group by --> having ---> select ---> order by  --> limit

----------------------
# DIFFERENCE BETWEEN where cluase and having 

-- order by count;PRIMARY

select * from sakila.rental where return_date is null;

select * from sakila.rental where customer_id = 33;
------------------------------
SELECT * FROM sakila.payment;

SELECT customer_id, sum(amount) as total_payment 
FROM sakila.payment
group by customer_id
having sum(amount) > 100 ;
-----------------------------------------
#Substring 
SELECT title, SUBSTRING(title, 1, 3) AS short_title 
FROM sakila.film;

----------------------
#concatination

SELECT CONCAT(first_name, '@ ', last_name) AS full_name 
FROM sakila.customer;

------------------------------
#length 

SELECT title, LENGTH(title) AS title_length 
FROM sakila.film 
WHERE LENGTH(title) > 15;
--------------------------------------
#substring with locate 
select email from sakila.customer;
SELECT email,
       SUBSTRING(email, LOCATE('@', email)+1) AS domain
FROM sakila.customer;

SELECT 
  email,
  substring_index(SUBSTRING(email, LOCATE('@', email) + 1), '.', 1) AS domain
FROM 
  sakila.customer;
  
select substring_index(email,'@', -1) from sakila.customer;

--------------------------
SELECT title
FROM sakila.film
WHERE UPPER(title) LIKE '%LOVELY%' OR UPPER(title) LIKE '%MAN';

select title, lower(title) as lower_titles
FROM sakila.film;
--------------------------------------------------
SELECT LEFT(title, 1) AS first_letter, right(title,1) as last_letter, COUNT(*) AS film_count
FROM sakila.film
GROUP BY LEFT(title, 1), right(title,1) 
ORDER BY film_count DESC;
-----
SELECT LEFT(title,1) AS first_letter, right(title, 1) as last_letter, title 
from sakila.film;

-------------------
SELECT last_name,
       CASE 
           WHEN LEFT(last_name, 1) BETWEEN 'A' AND 'M' THEN 'Group A-M'
           WHEN LEFT(last_name, 1) BETWEEN 'N' AND 'Z' THEN 'Group N-Z'
           ELSE 'Other'
       END AS group_label
FROM sakila.customer;

---------------

SELECT title, REPLACE(title, 'A', 'x') AS cleaned_title
FROM sakila.film
WHERE title LIKE '% ' '%';

-----------------
SELECT customer_id, last_name
FROM sakila.customer
WHERE last_name REGEXP '[^aeiouAEIOU]{3}'; -- decode

SELECT title
FROM sakila.film
WHERE title REGEXP '[aeiouAEIOU]$';

select right(title,1), count(*)
FROM sakila.film
WHERE title REGEXP '[aeiouAEIOU]$'
group by right(title,1)
;