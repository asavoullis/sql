--LEARNING SQL - MySQL w3schools.com

/*SQL Server is, by default case insensitive --
MySQL is a relational database management system
MySQL is open-source
MySQL is free
MySQL is ideal for both small and large applications
MySQL is very fast, reliable, scalable, and easy to use
MySQL is cross-platform
MySQL is compliant with the ANSI SQL standardwas first released in 1995
developed, distributed, and supported by Oracle Corporation 
*/


-- Structured Query Language
--lets you access and manipulate databases

--RDBMS: Relational Database Management System.


--What is a Database Table?
--A table is a collection of related data entries, and it consists of columns and rows.

--A column holds specific information about every record in the table.

--A record (or row) is each individual entry that exists in a table.


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

--WHERE-- 

--Displaying data entries of the database using WHERE
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



--INSERT INTO--

--Adding entries in the database
--It is also possible to only add data in specific columns.
--The following SQL statement will insert a new record, but only insert data in the "CustomerName", "City", and "Country" columns (CustomerID will be updated automatically):
INSERT INTO Customers (CustomerName, City, Country)
VALUES ('Cardinal', 'Stavanger', 'Norway');



--SELECT--

--Checking for null values using SELECT
--from the database Customers display the columns CustomerName, ContactName and Adress where the Address entries are EMPTY (null)
SELECT CustomerName, ContactName, Address
FROM Customers
WHERE Address IS NULL;
--WHERE Address IS NOT NULL;




--The UPDATE statement is used to modify the existing records in a table.

--Updates the Customers database's entry of CustomerID 1 with the ContactNmae set as Alfred Schmidt and City as Frankfurt
UPDATE Customers
SET ContactName = 'Alfred Schmidt', City = 'Frankfurt'
WHERE CustomerID = 1;


----updates the Customers database's entries which have country se to Mexico with the PostalCode 00000
UPDATE Customers
SET PostalCode = 00000
WHERE Country = 'Mexico';


--updates the customers database's entry of customerID = 32 with the city as Oslo and the Country as Norway
UPDATE Customers
SET City = 'Oslo',
Country = 'Norway'
WHERE CustomerID = 32;


--DELETE

--Delete all the entries of the database that are in the CustomerName column with the entry Alfeds Futterkiste
--Display it first: 
--Select * FROM Customers WHERE CustomerName='Alfreds Futterkiste';
DELETE FROM Customers WHERE CustomerName='Alfreds Futterkiste';



--SELECT TOP

--The SELECT TOP clause is used to specify the number of records to return.

--Not all database systems support the SELECT TOP clause. MySQL supports the LIMIT clause to select a limited number of records, while Oracle uses FETCH FIRST n ROWS ONLY and ROWNUM.


--selects the first three (using id index) records from the "Customers" table 
--SQL Server/ MS Access
SELECT TOP 3 * FROM Customers;

--selects the first three records (using id index) from the "Customers" table
--MySQL
SELECT * FROM Customers
LIMIT 3;

--selects the first three records (using id index) from the "Customers" table
--ORACLE
SELECT * FROM Customers
FETCH FIRST 3 ROWS ONLY;



--SELECT TOP + PERCENT 

--selects the first 50% of the records from the "Customers" table
--SQL Server/ Ms Acess
SELECT TOP 50 PERCENT * FROM Customers;

--selects the first 50% of the records from the "Customers" table
--ORACLE
SELECT * FROM Customers
FETCH FIRST 50 PERCENT ROWS ONLY;




--SELECT TOP + WHERE

--selects the first three records from the "Customers" table, where the country is "Germany"
--SQL Sever/ MS Access 
SELECT TOP 3 * FROM Customers
WHERE Country='Germany';

--MySQL
SELECT * FROM Customers
WHERE Country='Germany'
LIMIT 3;

--Oracle
SELECT * FROM Customers
WHERE Country='Germany'
FETCH FIRST 3 ROWS ONLY;



--MIN() and MAX() Functions

--MIN() function returns the smallest value of the selected column.
--MAX() function returns the largest value of the selected column.

--finds the price of the cheapest product
SELECT MIN(Price) AS SmallestPrice
FROM Products;

--finds the price of the cheapest product
SELECT MAX(Price) AS LargestPrice
FROM Products;



--COUNT(), AVG() and SUM() Functions

--COUNT() function returns the number of rows that matches a specified criterion.
--AVG() function returns the average value of a numeric column.
--SUM() function returns the total sum of a numeric column. 

--finds the number of products
SELECT COUNT(ProductID)
FROM Products;

--finds the average price of all products
SELECT AVG(Price)
FROM Products;

--finds the sum of the "Quantity" fields in the "OrderDetails" table
SELECT SUM(Quantity)
FROM OrderDetails;





