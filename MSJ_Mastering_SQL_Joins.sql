##########################################################
##########################################################
-- Guided Project: Mastering SQL Joins in PostgreSQL
##########################################################
##########################################################


#############################
-- Task One: Getting Started
-- In this task, we will retrieve data from the dept_manager_dup and
-- departments_dup tables in the database
#############################

-- 1.1: Retrieve all data from the dept_manager_dup table
SELECT *
FROM dept_manager_dup
ORDER BY dept_no;
-- Columns: emp_no, dept_no, from_date, to_date

-- 1.2: Retrieve all data from the departments_dup table
SELECT * FROM departments_dup 
ORDER BY dept_no;
-- Columns: dept_no, dept_name


#############################
-- Task Two: INNER JOIN
-- In this task, you will retrieve data from the two 
-- tables using INNER JOIN
#############################

##########
-- INNER JOIN

-- 2.1: Extract all managers' employees number, department number, 
-- and department name. Order by the manager's department number
SELECT m.emp_no, m.dept_no, d.dept_name
FROM dept_manager_dup m 
INNER JOIN departments_dup d
ON m.dept_no = d.dept_no
ORDER BY m.dept_no;
/* dept_no exists in both tables ( dept_manager_dup and departments_dup )
 but department name does NOT exist in dept_no */

-- add m.from_date and m.to_date
SELECT m.emp_no, m.dept_no, d.dept_name, m.from_date, m.to_date
FROM dept_manager_dup m 
INNER JOIN departments_dup d
ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- 2.2 (Ex.): Extract a list containing information about all managers'
-- employee number, first and last name, dept_number and hire_date
-- Hint: Use the employees and dept_manager tables

-- Retrieve data from the employees and dept_manager

SELECT * FROM employees;
-- Columns: emp_no, birth_date, first_name, last_name, gender, hire_date
SELECT * FROM dept_manager;
-- Columns: emp_no, dept_no, from_date, to_date

-- Solution to 2.2
SELECT m.emp_no, m.first_name, m.last_name, m.hire_date, d.dept_no
FROM employees m 
INNER JOIN dept_manager d
ON m.emp_no = d.emp_no
ORDER BY m.emp_no;

#############################
-- Task Three: Duplicate Records
-- In this task, you will retrieve data from the two 
-- tables with duplicate records using INNER JOIN
#############################

###########
-- Duplicate Records

-- 3.1: Let us add some duplicate records
-- Insert records into the dept_manager_dup and departments_dup tables respectively

INSERT INTO dept_manager_dup 
VALUES 	('110228', 'd003', '1992-03-21', '9999-01-01');
        
INSERT INTO departments_dup 
VALUES	('d009', 'Customer Service');

-- 3.2: Select all records from the dept_manager_dup table

SELECT *
FROM dept_manager_dup
ORDER BY dept_no ASC;

-- 3.3: Select all records from the departments_dup table

SELECT *
FROM departments_dup
ORDER BY dept_no ASC;

-- 3.4: Perform INNER JOIN as before
SELECT m.emp_no, m.dept_no, d.dept_name
FROM dept_manager_dup m
INNER JOIN departments_dups d
ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- 3.5: add a GROUP BY clause. Make sure to include all the fields in the GROUP BY clause
SELECT m.emp_no, m.dept_no, d.dept_name
FROM dept_manager_dup m
INNER JOIN departments_dup d
ON m.dept_no = d.dept_no
GROUP BY m.emp_no, m.dept_no, d.dept_name
ORDER BY m.dept_no;


#############################
-- Task Four: LEFT JOIN
-- In this task, you will retrieve data from the two tables using LEFT JOIN
#############################

###########
-- LEFT JOIN
/* A left join retrieves all the records from the left table 
and those records that satisfy a condition from the right table 
also note that any records that do not have a matching value with the
right table, the output will be NULL */ 

-- 4.1: Remove the duplicates from the two tables
DELETE FROM dept_manager_dup 
WHERE emp_no = '110228';
        
DELETE FROM departments_dup 
WHERE dept_no = 'd009';

-- 4.2: Add back the initial records
INSERT INTO dept_manager_dup 
VALUES 	('110228', 'd003', '1992-03-21', '9999-01-01');
        
INSERT INTO departments_dup 
VALUES	('d009', 'Customer Service');

-- 4.3: Select all records from dept_manager_dup
SELECT *
FROM dept_manager_dup
ORDER BY dept_no;

-- 4.4: Select all records from departments_dup
SELECT *
FROM departments_dup
ORDER BY dept_no;

-- Recall, when we had INNER JOIN (or JOIN are same thing)
SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
JOIN departments_dup d 
ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- 4.5: Join the dept_manager_dup and departments_dup tables
-- Extract a subset of all managers' employee number, department number, 
-- and department name. Order by the managers' department number
SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
LEFT JOIN departments_dup d 
ON m.dept_no = d.dept_no
ORDER BY m.dept_no;
/* returns all the records on the left table (dept_manager_dup) and where
they match with the right table - null means no record in the right table
*/

-- 4.6: What will happen when we d LEFT JOIN m? (change order of tables)
SELECT m.dept_no, m.emp_no, d.dept_name
FROM departments_dup d
LEFT JOIN dept_manager_dup m
ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- 4.7: Let's select d.dept_no
SELECT m.dept_no, m.emp_no, d.dept_name
FROM departments_dup d
LEFT JOIN dept_manager_dup m
ON m.dept_no = d.dept_no
ORDER BY d.dept_no;
/* changed ORDER BY from m.dept_no to d.dept_no 
this changes the order but same amount of records */

-- LEFT OUTER JOIN (same as LEFT JOIN)
SELECT m.dept_no, m.emp_no, d.dept_name
FROM departments_dup d
LEFT OUTER JOIN dept_manager_dup m
ON m.dept_no = d.dept_no
ORDER BY d.dept_no;

#############################
-- Task Five: RIGHT JOIN
-- In this task, you will retrieve data from the two tables using RIGHT JOIN
#############################

###########
-- RIGHT JOIN

-- We have seen LEFT JOIN in the previous task

SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
LEFT JOIN departments_dup d 
ON m.dept_no = d.dept_no
ORDER BY dept_no;

-- 5.1: Let's use RIGHT JOIN
SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
RIGHT JOIN departments_dup d
ON m.dept_no = d.dept_no
ORDER BY dept_no;

-- 5.2: SELECT d.dept_no (only the order of records changes)
SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
RIGHT JOIN departments_dup d
ON m.dept_no = d.dept_no
ORDER BY d.dept_no;

-- 5.3: d LEFT JOIN m
SELECT m.dept_no, m.emp_no, d.dept_name
FROM departments_dup d
LEFT JOIN dept_manager_dup m
ON m.dept_no = d.dept_no
ORDER BY dept_no;

#############################
-- Task Six: JOIN and WHERE Used Together
-- In this task, you will retrieve data from tables
-- using JOIN and WHERE together
#############################

###########
-- JOIN and WHERE Used Together

-- 6.1: Extract the employee number, first name, last name and salary
-- of all employees who earn above 145000 dollars per year

-- Let us retrieve all data in the salaries table
SELECT * FROM salaries;

-- Solution to 6.1
SELECT e.emp_no, e.first_name, e.last_name, s.salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no
WHERE salary > 145000;


-- 6.2: What do you think will be the output of this query?
/* we just didn't include the employees number  */
SELECT e.first_name, e.last_name, s.salary
FROM employees e
JOIN salaries s 
ON e.emp_no = s.emp_no
WHERE s.salary > 145000;

-- 6.3 (Ex.): Select the first and last name, the hire date and the salary
-- of all employees whose first name is 'Mario' and last_name is 'Straney'
SELECT e.first_name, e.last_name, e.hire_date, s.salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no
WHERE e.first_name = 'Mario'
AND e.last_name = 'Straney'
ORDER BY e.emp_no;

-- 6.4: Join the 'employees' and the 'dept_manager' tables to return a subset
-- of all the employees whose last name is 'Markovitch'. 
-- See if the output contains a manager with that name
/* Margareta is a manager (Full row record data + different emp_no - 6 digits) */
SELECT e.emp_no, e.first_name, e.last_name, dm.dept_no, dm.from_date
FROM employees e
LEFT JOIN dept_manager dm
ON e.emp_no = dm.emp_no
WHERE e.last_name = 'Markovitch'
ORDER BY dm.dept_no, e.emp_no;

-- 6.5: Join the 'employees' and the 'dept_manager' tables to return a subset
-- of all the employees who were hired before 31st of January, 1985
SELECT e.emp_no, e.first_name, e.last_name, dm.dept_no, dm.from_date
FROM employees e
LEFT JOIN dept_manager dm
ON e.emp_no = dm.emp_no
WHERE e.hire_date < '1985-01-31'
ORDER BY dm.dept_no, e.emp_no;


#############################
-- Task Seven: Using Aggregate Functions with Joins
-- In this task, you will retrieve data from tables in the employees database,
-- using Aggregate Functions with Joins
#############################

###########
-- Using Aggregate Functions with Joins

-- 7.1: What is the average salary for the different gender?
SELECT e.gender, ROUND(AVG(salary),2) AS average_salary
FROM employees e
INNER JOIN salaries s 
ON e.emp_no = s.emp_no
GROUP BY e.gender;

-- 7.2: What do you think will be the output if we SELECT e.emp_no?
SELECT e.emp_no, e.gender, AVG(s.salary) AS average_salary
FROM employees e
JOIN salaries s 
ON e.emp_no = s.emp_no
GROUP BY e.emp_no, gender; 

-- 7.3: How many males and how many females managers do we have in
-- employees database?
SELECT e.gender, COUNT(dm.emp_no)
FROM employees e
JOIN dept_manager dm
ON e.emp_no = dm.emp_no
GROUP BY e.gender; 


#############################
-- Task Eight: Join more than Two Tables in SQL
-- In this task, you will retrieve data from tables in the employees database,
-- by joining more than two Tables in SQL
#############################

###########
-- Join more than Two Tables in SQL

-- 8.1: Extract a list of all managers' first and last name, dept_no, hire date, to_date,
-- and department name
SELECT e.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date, m.to_date, d.dept_name
FROM employees e
JOIN dept_manager m 
ON e.emp_no = m.emp_no
JOIN departments d
ON m.dept_no = d.dept_no;


-- 8.2: What do you think will be the output of this?
/* only the employee number will be left out the rest is the same as its inner join */
SELECT e.first_name, e.last_name, m.dept_no, e.hire_date, m.to_date, d.dept_name
FROM departments d
JOIN dept_manager m 
ON d.dept_no = m.dept_no
JOIN employees e 
ON m.emp_no = e.emp_no;

-- 8.3: Retrieve the average salary for the different departments

-- Retrieve all data from departments table
SELECT * FROM departments

-- Retrieve all data from dept_emp table
SELECT * FROM dept_emp

-- Retrieve all data from salaries table
SELECT * FROM salaries

-- Solution to 8.3
SELECT d.dept_name, AVG(salary) as average_salary
FROM departments d
JOIN dept_emp de
ON d.dept_no = de.dept_no
JOIN salaries s
ON de.emp_no = s.emp_no
GROUP BY d.dept_name
ORDER BY AVG(salary) DESC;

-- 8.4 (Ex.): Retrieve the average salary for the different departments where the
-- average_salary is more than 60000
SELECT d.dept_name, AVG(salary) as average_salary
FROM departments d
JOIN dept_emp de
ON d.dept_no = de.dept_no
JOIN salaries s
ON de.emp_no = s.emp_no
GROUP BY d.dept_name
HAVING AVG(salary) > 60000
ORDER BY AVG(salary) DESC;

