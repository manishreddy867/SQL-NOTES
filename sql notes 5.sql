## Cluster index 
it is the physical order of data in a table
CREATE TABLE student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100)
);

## non cluster index
it is a separate structure from actual table data
Stores pointers (addresses) to the actual rows
SELECT *
FROM customer
WHERE last_name = 'SMITH';

## Natural key 
it is uniquely identified naturally 
like ssn, vin,passport number
CREATE TABLE employee (
    ssn VARCHAR(20) PRIMARY KEY,
    employee_name VARCHAR(100)
);

## Surrogate key 
Surrogate Key = System-generated unique identifier

SELECT *
FROM customer
WHERE customer_id = 5;

