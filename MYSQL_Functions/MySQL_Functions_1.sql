---------------- MYSQL  Functions  -----------------

-- https://www.coursera.org/learn/sql-functions/
/*
Task 1: Numeric Functions
Task 2: String Functions
Task 3: Date and Time Functions
Task 4: Null Functions
Task 5: Stored Functions
Task 6: Stored Procedures
*/

----------------------------------------------------------------
SELECT GREATEST(2, 455, 33, 315, 125);
-- 455
-- Selects the greatest number from the list provided

SELECT LEAST(2, 455, 33, 315, 125);
-- 2
-- Selects the smallest number from the list provided

SELECT RAND();
-- 0.12152151251
-- Returns a random number

USE bookstore;

SELECT * FROM bookstore.item;
-- returns the structure of the table

SELECT COUNT(id)
FROM item
WHERE booktitle ='Harry Potter';
-- returns the amount of rows that meets that criteria

SELECT id, booktitle, author, MIN(price)
FROM item;
-- selects the entry with the lowest minimum price

----------------------------------------------------------------
-- GENERAL + NUMERICAL FUNCTIONS
-- SUM / AVG / COUNT / MIN / MAX

SELECT UPPER(firstname), LOWER(lastname)
FROM customers;

SELECT REPLACE(booktitle, 'o', 'HI')
FROM item;
-- Replace anywhere in the booktitle column the letter o with hi
-- It does not modify the table, only what we get on the output

SELECT REVERSE(firstname)
FROM customers;

SELECT CONCAT(firstname, ' ', lastname) AS fullname
FROM customers;

SELECT LENGTH(firstname), LENGTH(lastname)
FROM customers;
-- returns the number of characters 

SELECT DISTINCT(UPPER(booktitle))
FROM item;

SELECT CONCAT(booktitle, ' ', author) AS book
FROM item;

----------------------------------------------------------------
-- DATE-TIME FUNCTIONS 

SELECT DATE(orderdate), id
FROM orders
WHERE orderdate > '2020-05-10';
-- Extracts the date from the column

SELECT NOW();
-- Returns the current date and time

SELECT DATE(NOW());
-- Select only the current date 

SELECT TIME(NOW());
-- Selects only the current time

SELECT DATE_FORMAT(CURDATE(), '%Y/%m/%d') AS today;
-- Returns the current date in a specific format

SELECT DATEDIFF('2020-10-20','2015-10-20') AS Days;
-- Returns the date difference

SELECT '2020-01-01' start,
DATE_ADD('2020-01-01', INTERVAL 1 DAY) 'one day after',
DATE_ADD('2020-01-01', INTERVAL 1 YEAR) 'one year after';
-- we gave it a value to start and it will output the date calculations for the interval provided

SELECT '2020-01-01' start,
DATE_SUB('2020-01-01', INTERVAL 1 DAY) 'one day earlier',
DATE_SUB('2020-01-01', INTERVAL 1 YEAR) 'one year earlier';
-- SUBTRACTING

----------------------------------------------------------------
-- NULL FUNCTIONS

SELECT id, firstname, IFNULL(lastname, 'NA') lastname
FROM customers;
-- any rows that don't have a value in the lastname column they will be filled with NA

SELECT id, firstname, lastname, COALESCE(phone, address, 'NA') AS contact
FROM customers;
-- returns the first which is not NULL from the columns phone and address and if both are NULL it will return NA

SELECT id, firstname, lastname, COALESCE(NULLIF(address, ''), phone, 'NA') AS contact
FROM customers;
-- NULLIF accepts 2 arguments if the first 2 arguments are equal it will return null otherwise it will return the first argument
-- if an empty string or null value was accidentally inserted into the row it won't return an empty string

----------------------------------------------------------------
-- STORED FUNCTIONS
-- Is a database object that is often called a user defined function
-- It is called from an SQL statment like a regular function and returns a single value 
-- to the environment in which it was called
-- it can modify or update the data in the table as well

-- We do this because in a stored function we can have multiple SQL queries
-- and normally we end a statement by using the ; (semicolon) 
-- and we change the delimiter to make sure that whenever the SQL interpreter hits the ; 
-- it doesn't stop the rest of the function from carrying on
DELIMITER //

CREATE FUNCTION customer_agebracket(age int)
RETURNS VARCHAR(20)
DETERMINISTIC 
-- This means that it always gives the same answer for the function when it has the same input

BEGIN
	DECLARE customer_status VARCHAR(20);
	IF age < 18 THEN 
		SET customer_status = 'Under 18';
	ELSEIF(age >= 18 AND age < 35) THEN
		SET customer_status = '18 to 35';
	ELSEIF age >= 35 THEN
		SET customer_status = 'Over 35'
	END IF;
	RETURN(customer_status);
END // 
DELIMITER ;

SELECT firstname, lastname customer_agebracket(age) 
FROM customers;



CREATE FUNCTION bookPrice(price int)
RETURNS VARCHAR(20)
DETERMINISTIC 

BEGIN
	DECLARE booklevel VARCHAR(20);
	IF price <= 7 THEN 
		SET booklevel = 'BUDGET';
	ELSEIF price > 7 THEN
		SET booklevel = 'LUXURY';
	END IF;
	RETURN(booklevel);
END // 
DELIMITER ;


SELECT booktitle, bookPrice(price)
FROM item;

----------------------------------------------------------------
-- STORED Procedures
-- It is a prepared SQL code that you can save in order to be reused
-- can act according to the parameters passed

-- make a procedure to add a new book into the item table
DELIMITER // 
CREATE PROCEDURE InsertBook(
	IN id INT,
	IN booktitle VARCHAR(100),
	IN author VARCHAR(100)
)
BEGIN
INSERT INTO item(id, booktitle, author)
VALUES (id, booktitle, author);
END //
DELIMITER ;

CALL InsertBook(15, 'The Flatshare', 'Beth Oleary');

SELECT * FROM item;


-- Create a store procedure that would print a person's name to screen and say welcome
DELIMITER // 
CREATE PROCEDURE Welcome(
	welcome VARCHAR(100),
	nameperson VARCHAR(100)
)
BEGIN
DECLARE WelcomeStatement VARCHAR(100)
SET WelcomeStatement=CONCAT(welcome, ' ', nameperson);
END //
DELIMITER ;

CALL Welcome('Welcom', 'Emma');

----------------------------------------------------------------

-- Quiz

-- What is a stored function?
-- Returns a single value and returns it in the environment in which it was called.

-- What is a stored procedure?
-- A prepared SQL code that you can save, so that the code can be reused again.




















