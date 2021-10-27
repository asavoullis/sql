#LEARNING SQL - MySQL

-- SQL Server is, by default case insensitive --
--MySQL is a relational database management system
--MySQL is open-source
--MySQL is free
--MySQL is ideal for both small and large applications
--MySQL is very fast, reliable, scalable, and easy to use
--MySQL is cross-platform
--MySQL is compliant with the ANSI SQL standard
--was first released in 1995
-- developed, distributed, and supported by Oracle Corporation

-- Structured Query Language
--lets you access and manipulate databases

--RDBMS stands for Relational Database Management System.


--What is a Database Table?
--A table is a collection of related data entries, and it consists of columns and rows.

--A column holds specific information about every record in the table.

--A record (or row) is each individual entry that exists in a table.


---
--Some database systems require a semicolon at the end of each SQL statement.

--Semicolon is the standard way to separate each SQL statement in database systems that allow more than one SQL statement to be executed in the same call to the server.

/*
Some of The Most Important SQL Commands

SELECT - extracts data from a database
UPDATE - updates data in a database
DELETE - deletes data from a database
INSERT INTO - inserts new data into a database
CREATE DATABASE - creates a new database
ALTER DATABASE - modifies a database
CREATE TABLE - creates a new table
ALTER TABLE - modifies a table
DROP TABLE - deletes a table
CREATE INDEX - creates an index (search key)
DROP INDEX - deletes an index
*/





-- from the file Customer import everything
SELECT * FROM Customers; --selects entire DB


--selects only these columns
SELECT CustomerName, City, Country FROM Customers;


--selects unique/distinct values from the column
SELECT DISTINCT Country FROM Customers;
     

--counts only the 	 
SELECT COUNT(DISTINCT Country) FROM Customers;


--WHERE is used to extract only those records that fulfill a specified condition.
SELECT * FROM Customers WHERE Country = 'Mexico';


SELECT * FROM Customers
WHERE Country='Mexico' AND PostalCode='05021';


SELECT * FROM Customers
WHERE Country='Mexico' OR Country='Canada';        

SELECT * FROM Customers
WHERE CustomerID = 1;

/*
Operators in The WHERE Clause
Operator	Description	Example
=	Equal	
>	Greater than	
<	Less than	
>=	Greater than or equal	
<=	Less than or equal	
<>	Not equal. Note: In some versions of SQL this operator may be written as !=	
BETWEEN	Between a certain range	
LIKE	Search for a pattern	
IN	To specify multiple possible values for a column

*/

SELECT * FROM Customers
WHERE NOT City ='Berlin';

SELECT * FROM Customers
WHERE Country = 'Germany' AND (City = 'Berlin' OR City = 'Stuttgart');


--ORDER BY

SELECT * FROM Customers
ORDER BY Country;

--descending order
SELECT * FROM Customers
ORDER BY Country DESC;


--The following SQL statement selects all customers from the "Customers" table, sorted by the "Country" and the "CustomerName" column. This means that it orders by Country, but if some rows have the same Country, it orders them by CustomerName:
SELECT * FROM Customers
ORDER BY Country DESC;


--The following SQL statement selects all customers from the "Customers" table, sorted ascending by the "Country" and descending by the "CustomerName" column:
SELECT * FROM Customers
ORDER BY Country ASC, CustomerName DESC;


--It is also possible to only insert data in specific columns.
--The following SQL statement will insert a new record, but only insert data in the "CustomerName", "City", and "Country" columns (CustomerID will be updated automatically):
INSERT INTO Customers (CustomerName, City, Country)
VALUES ('Cardinal', 'Stavanger', 'Norway');

--Checking for null values
SELECT CustomerName, ContactName, Address
FROM Customers
WHERE Address IS NULL;
--WHERE Address IS NOT NULL;


--The UPDATE statement is used to modify the existing records in a table.
UPDATE Customers
SET ContactName = 'Alfred Schmidt', City = 'Frankfurt'
WHERE CustomerID = 1;

--OR
UPDATE Customers
SET PostalCode = 00000
WHERE Country = 'Mexico';

--OR
UPDATE Customers
SET City = 'Oslo',
Country = 'Norway'
WHERE CustomerID = 32;