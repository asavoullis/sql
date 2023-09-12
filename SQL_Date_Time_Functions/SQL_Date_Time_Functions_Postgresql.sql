###############################################################
###############################################################
-- Guided Project: SQL Date-Time Functions
###############################################################
###############################################################


#############################
-- Task One: Getting Started
-- In this task, we will retrieve data from the tables in the
-- employees database
#############################

-- 1.1: Retrieve all the data in the employees, sales, dept_manager, salaries table
SELECT * FROM employees;
SELECT * FROM sales;
SELECT * FROM dept_manager;
SELECT * FROM salaries;

#############################
-- Task Two: Current Date & Time
-- In this task, we will learn how to use a number of functions 
-- that return values related to the current date and time. 
#############################

-- 2.1: Retrieve the current date
SELECT CURRENT_DATE

-- 2.2: Retrieve the current time
SELECT CURRENT_TIME
"10:01:05.276804+00:00"

-- 2.3: Retrieve the current timestamp
SELECT CURRENT_TIMESTAMP
--"2023-09-12 09:59:09.809384+00"
SELECT CURRENT_TIMESTAMP(1)
--"2023-09-12 09:59:57.6+00"

-- 2.4: Retrieve the current date, current date, time, and timestamp
SELECT CURRENT_DATE, CURRENT_TIME, CURRENT_TIME(1), CURRENT_TIME(3), CURRENT_TIMESTAMP;

-- 2.5: Retrieve the time of the day
SELECT transaction_timestamp();
SELECT timeofday();
SELECT now();

#############################
-- Task Three: AGE() - Part One
-- In this task, we will learn how to use the AGE() function to subtract arguments, 
-- producing a "symbolic" result that uses years and months
#############################

-- 3.1: Check the difference between February 28th, 2021 and December 31st, 2019
SELECT AGE('2021-02-28','2019-12-31');
--"1 year 1 mon 28 days"


-- 3.2: How old is the Batman movie that was released March 30, 1939
SELECT AGE(CURRENT_DATE,'1939-03-30') AS Batman_Age;

-- 3.3: Retrieve a list of the current age of all employees
SELECT * FROM employees;
SELECT first_name, last_name, birth_date, AGE(CURRENT_DATE,birthdate) as Age 
FROM employees;


-- 3.4: Retrieve a list of all employees ages as at when they were employed
SELECT first_name, last_name, birth_date, AGE(hire_date,birthdate) as Age 
FROM employees;


-- 3.5: Retrieve a list of how long a manager worked at the company
SELECT e.emp_no, e.first_name, dm.dept_no, AGE(CURRENT_DATE,e.hire_date) as Time_Employed
FROM employees e
INNER JOIN dept_manager dm
ON e.emp_no = dm.emp_no;


SELECT emp_no, dept_no, AGE(TO_DATE,from_Date) as Time_Employed
FROM dept_manager


-- 3.6: Retrieve a list of how long a manager have been working at the company
-- We have 24 managers but only some of them (indicated by the column to_date as "9999-01-01") are still working here 
-- The rest have a date that has passed eg "1999-01-01"
-- This is how we find how long they have been working since they were hired
SELECT emp_no, AGE(CURRENT_DATE, from_date) AS Age 
FROM dept_manager
WHERE emp_no IN ('110039', '110114', '110228', '110420', '110567', '110854', '111133', '111534','111939');


-- EXTRA TASKS --

--Calculate a column that indicates whether a manager is still employed or when they left
SELECT emp_no, 
CASE 
WHEN to_date = '9999-01-01' THEN 'STILL EMPLOYED'
	ELSE TO_date::TEXT
END AS employment_durration
FROM dept_manager

-- ALSO provide his name from the Employees table
SELECT dm.emp_no, e.first_name,
CASE 
WHEN to_date = '9999-01-01' THEN 'STILL EMPLOYED'
	ELSE TO_date::TEXT
END AS employment_durration
FROM dept_manager dm
INNER JOIN employees e
USING(emp_no)


-- 2 new columns , first if he is still employed or when he was last employed
-- second is how much 
SELECT dm.emp_no, e.first_name,
CASE 
WHEN to_date = '9999-01-01' THEN 'STILL EMPLOYED'
	ELSE TO_date::TEXT
END AS employment_durration,
CASE
	WHEN dm.to_date = '9999-01-01' THEN AGE(CURRENT_DATE,dm.from_date)
	ELSE AGE(to_date,from_date)
END AS employment_durration2
FROM dept_manager dm
INNER JOIN employees e
USING(emp_no)


-- Write a query to retrieve a list of the current age of all employees in the employees database.
SELECT birth_date, AGE(CURRENT_DATE, birth_date) AS Age
FROM employees;



#############################
-- Task Four: AGE() - Part Two
-- In this task, we will learn how the AGE() function to subtract arguments, 
-- producing a "symbolic" result that uses years and months
#############################

-- 4.1: Retrieve a list of how long a manager worked at the company
SELECT emp_no,
CASE
	WHEN AGE(to_date, from_date) < AGE(CURRENT_DATE,from_date) THEN AGE(to_date,from_date)
	ELSE AGE(CURRENT_DATE,from_date)
END 
From dept_manager



-- 4.2: Retrieve a list of how long it took to ship a product to a customer
SELECT * FROM sales;
SELECT order_line,order_id,ship_date,AGE(ship_date,order_date) AS time_taken
FROM sales
ORDER BY time_taken DESC;


-- 4.3: Retrieve all the data from the salaries table
SELECT * FROM salaries;

-- salary data from salaries table, employee data from employees table

-- 4.4: Retrieve a list of the first name, last name, salary 
-- and how long the employee earned that salary
SELECT e.first_name, e.last_name, e.emp_no, s.salary,AGE(s.to_date,s.from_date)
FROM employees e
INNER JOIN salaries s
USING (emp_no)
ORDER BY salary DESC;



-- A better result
SELECT e.first_name, e.last_name, s.salary, s.from_date, s.to_date,
CASE
	WHEN AGE(to_date, from_date) < AGE(CURRENT_DATE, from_date) THEN AGE(to_date, from_date)
	ELSE AGE(CURRENT_DATE, from_date)
END 
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no;










#############################
-- Task Five: EXTRACT() - Part One
-- In this task, we will see how the EXTRACT() function 
-- to retrieve subfields like year or hour from date/time values
#############################


-- 5.1: Extrac the day of the month from the current date
SELECT EXTRACT(DAY FROM CURRENT_DATE); 
-- will return 12 for 2023/09/12


-- 5.2: Extract the day of the week from the current date
SELECT EXTRACT(ISODOW FROM CURRENT_DATE);
-- WILL RETURN 2 FOR TUESDAY for example


-- 5.3: Extract the hour of the day from the current date
SELECT CURRENT_TIMESTAMP,EXTRACT(HOUR FROM CURRENT_TIMESTAMP);
--"2023-09-12 14:20:02.214074+00"	14


-- 5.4: What do you think this result will be?
SELECT EXTRACT(DAY FROM DATE('2019-12-31'));
-- 31

-- 5.5: What do you think this result will be?
SELECT EXTRACT(YEAR FROM DATE('2019-12-31'));
-- 2019

-- 5.6: What about this one?
SELECT EXTRACT(MINUTE from '084412'::TIME);
-- 44 , 08:44:12


-- 5.7: Retrieve a list of the ship mode and how long (in seconds) it took to ship a product to a customer
SELECT order_line, order_date, ship_date, ship_mode
(EXTRACT(EPOCH FROM ship_date)-EXTRACT(EPOCH FROM order_date)) AS secs_taken
FROM sales;


-- 5.8: Retrieve a list of the ship mode and how long (in days) it took to ship a product to a customer
SELECT order_line, order_date, ship_date, ship_mode
(EXTRACT(DAY FROM ship_date) - EXTRACT(DAY FROM order_date)) AS days_taken
FROM sales
ORDER BY days_taken DESC;


-- 5.9: Retrieve a list of the current age of all employees
SELECT first_name, last_name, birth_date, 
(EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM birth_date)) AS emp_age
FROM employees;



-- 5.10: Retrieve a list of the current age of all employees
SELECT first_name, last_name, birth_date, 
(EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM birth_date)) || ' years' AS emp_age
FROM employees;



#############################
-- Task Six: EXTRACT() - Part Two
-- In this task, we will see how the EXTRACT() function 
-- to retrieve subfields like year or hour from date/time values
#############################

-- 6.1: Retrieve a list of all employees ages as at when they were employed
SELECT first_name, last_name, birth_date, hire_date,
(EXTRACT(YEAR FROM hire_date)-EXTRACT(YEAR FROM birth_date)) AS Age_Employed
FROM employees;


-- 6.2: Retrieve a list of all employees who were 25 or less than 25 years as at when they were employed
SELECT first_name, last_name, birth_date, hire_date, 
(EXTRACT(YEAR FROM hire_date) - EXTRACT(YEAR FROM birth_date)) AS Employed_25
FROM employees
WHERE (EXTRACT(YEAR FROM hire_date) - EXTRACT(YEAR FROM birth_date)) <= 25;


-- 6.3: How many employees were 25 or less than 25 years as at when they were employed
SELECT  
COUNT(EXTRACT(YEAR FROM hire_date) - EXTRACT(YEAR FROM birth_date)) AS Num_employed_25
FROM employees
WHERE (EXTRACT(YEAR FROM hire_date) - EXTRACT(YEAR FROM birth_date)) <= 25;


-- 6.4: What do you think will be the result of this query?
SELECT (EXTRACT(YEAR FROM hire_date) - EXTRACT(YEAR FROM birth_date)) || ' years' AS Age_group,
COUNT((EXTRACT(YEAR FROM hire_date) - EXTRACT(YEAR FROM birth_date))) AS Num_Employed
FROM employees
WHERE (EXTRACT(YEAR FROM hire_date) - EXTRACT(YEAR FROM birth_date)) <= 25
GROUP BY age_group
ORDER BY age_group;



-- 6.5: Retrieve all data from the sales table
SELECT * FROM sales;


-- 6.6: Retrieve a list of the product_id, the month of sales and sales
-- for chair sub category in the year 2015
SELECT product_id, sub_category, EXTRACT(MONTH FROM ship_date) AS sales_month, sales
FROM sales
WHERE sub_category = 'Chairs' AND order_id LIKE '%2015%';


-- 6.7: Retrieve a list of the month of sales and sum of sales
-- for each month for chair sub category in the year 2015
SELECT EXTRACT(MONTH FROM ship_date) AS sales_month, SUM(sales) AS monthly_total
FROM sales
WHERE sub_category = 'Chairs' AND order_id LIKE '%2015%'
GROUP BY sales_month
ORDER BY sales_month;


SELECT product_id, sub_category,EXTRACT(MONTH FROM ship_date) AS sales_month, SUM(sales) AS monthly_total
FROM sales
WHERE sub_category = 'Chairs' AND order_id LIKE '%2015%'
GROUP BY sales_month,product_id,sub_category
ORDER BY sales_month;






#############################
-- Task Seven: Converting Date to Strings
-- In this task, we will see how to convert dates to strings
#############################

-- 7.1: Change the order date in the sales table to strings
SELECT order_date, TO_CHAR(order_date, 'MMDDYY') FROM sales;


-- 7.2: Change the order date in the sales table to strings
SELECT order_date, TO_CHAR(order_date, 'Month DD, YYYY') FROM sales;
SELECT order_date, TO_CHAR(order_date, 'Month FMDDth, YYYY') FROM sales;

-- 7.3: Change the order date in the sales table to strings
SELECT order_date, TO_CHAR(order_date, 'Month DAY, YYYY') FROM sales;


-- 7.4: What do you think will be the result of this?
SELECT order_date, TO_CHAR(order_date, 'Month DAY, YYYY')
FROM sales;


-- 7.5: What do you think will be the result of this?
SELECT *, TO_CHAR(hire_date, 'Day, Month DD YYYY') AS hired_date
FROM employees;


-- 7.6: Retrieve a list of the month of sales and sum of sales
-- for each month for chair sub category in the year 2015
SELECT TO_CHAR(ship_date, 'Month') AS sales_month, SUM(Sales) as monthly_total
FROM sales;
WHERE sub_category = 'Chairs' AND order_id LIKE '%2015%'
GROUP BY full_sales_month
ORDER BY full_sales_month;


-- 7.7: Retrieve a list of the month of sales and sum of sales
-- for each month in the right order for chair sub category in the year 2015
SELECT EXTRACT(MONTH FROM ship_date) AS sales_month
TO_CHAR(ship_date, 'Month') AS sales_month, SUM(Sales) as monthly_total
FROM sales;
WHERE sub_category = 'Chairs' AND order_id LIKE '%2015%'
GROUP BY full_sales_month, sales_month
ORDER BY sales_month;


-- 7.8: Add a currency (dollars) to the sum of monthly sales
-- L adds a dollar sign ( you can also use $ ) 
SELECT EXTRACT(MONTH FROM ship_date) AS sales_month, 
TO_CHAR(ship_date, 'Month') AS full_sales_month, TO_CHAR(SUM(sales), 'L99999.99') AS monthly_total
FROM sales
WHERE sub_category = 'Chairs' AND order_id LIKE '%2015%'
GROUP BY full_sales_month, sales_month
ORDER BY sales_month;

#############################
-- Task Eight: Converting Strings to Date
-- In this task, we will see how to convert strings to dates
#############################

-- 8.1: Change '2019/12/31' to the correct date format
SELECT TO_DATE('2019-12-31', 'YYYY/MM/DD');


-- 8.2: Change '20191231' to the correct date format
SELECT TO_DATE('20191231', 'YYYYMMDD');


-- 8.3: Change '191231' to the correct date format
SELECT TO_DATE('191231', 'YYMMDD');


-- 8.4: What do you think will be the result of this?
SELECT TO_DATE('123119', 'MMDDYY');


-- 8.5: Retrieve all the data from the employees table
SELECT * FROM employees;


-- Start transaction
BEGIN;

ALTER TABLE employees
ALTER COLUMN hire_date TYPE CHAR(10);

SELECT * FROM employees;

-- Change the hire_date to a correct date format
SELECT *, TO_DATE(hire_date, 'YYYY-MM-DD') AS hire_date 
FROM employees;

-- End the transaction
ROLLBACK;



/* QUIZ */

--Which of the following keywords is used to initialize or start a transaction block in PostgreSQL? 
--BEGIN

--
/*SELECT birth_date,
(EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM birth_date)) || ' years' AS emp_age
FROM employees;
*/

-- Which of these EXTRACT fields returns the number of seconds between two dates?
-- EPOCH

-- Which function can be used to convert strings to date in PostgreSQL?
-- TO_CHAR()

/*
What are the two arguments that the TO_CHAR() function takes as input?
value and format_mask
TO_CHAR() function converts a number or date to a string. Often you don’t want to show the full raw TIMESTAMP, but rather a nicely formatted, potentially truncated version. Typically, it is written as TO_CHAR(value, format_mask).


SELECT EXTRACT(MONTH FROM ship_date) AS sales_month, 
SUM(sales) AS monthly_total
FROM sales
GROUP BY sales_month
ORDER BY sales_month;
The query above retrieves a list of the month of sales and the sum of the total sales for each month in the sales table. Then, it sorts the result by the month of sales in ascending order.
*/



