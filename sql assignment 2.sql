SELECT first_name,
       last_name,
       email,
       COUNT(*) AS duplicate_count
FROM customer
GROUP BY first_name,
         last_name,
         email
HAVING COUNT(*) > 1;
------------------------------------------
SELECT SUM(
       LENGTH(description)
       - LENGTH(REPLACE(LOWER(description),'a',''))
       ) AS total_a_count
FROM film;
-------------------------------------------
SELECT
SUM(LENGTH(LOWER(description))
    - LENGTH(REPLACE(LOWER(description),'a',''))) AS A_Count,

SUM(LENGTH(LOWER(description))
    - LENGTH(REPLACE(LOWER(description),'e',''))) AS E_Count,

SUM(LENGTH(LOWER(description))
    - LENGTH(REPLACE(LOWER(description),'i',''))) AS I_Count,

SUM(LENGTH(LOWER(description))
    - LENGTH(REPLACE(LOWER(description),'o',''))) AS O_Count,

SUM(LENGTH(LOWER(description))
    - LENGTH(REPLACE(LOWER(description),'u',''))) AS U_Count

FROM film;
--------------------------------------------------------
SELECT customer_id,
       MONTH(payment_date) AS month_no,
       MONTHNAME(payment_date) AS month_name,
       SUM(amount) AS total_payment
FROM payment
GROUP BY customer_id,
         MONTH(payment_date),
         MONTHNAME(payment_date)
ORDER BY customer_id;

SELECT customer_id,
       YEAR(payment_date) AS payment_year,
       SUM(amount) AS total_payment
FROM payment
GROUP BY customer_id,
         YEAR(payment_date)
ORDER BY customer_id;
---------------------------------------------
SELECT
CASE
    WHEN (2025 % 400 = 0)
         OR (2025 % 4 = 0 AND 2025 % 100 <> 0)
    THEN 'Leap Year'
    ELSE 'Not a Leap Year'
END AS Result; 
------------------------------------------------
SELECT DATEDIFF(
       CONCAT(YEAR(CURDATE()),'-12-31'),
       CURDATE()
       ) AS Days_Remaining;
--------------------------------------------------
SELECT payment_id,
       payment_date,
       CONCAT('Q', QUARTER(payment_date)) AS Quarter_No
FROM payment;
----------------------------------------------


