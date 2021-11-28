-- Learning SQL 2 - MySQL

/*Revision:*/


--Select all records where City is NOT "Berlin".
SELECT * FROM Customers
WHERE NOT City = 'Berlin';

--Select all records where the CustomerID column has the value 32.
SELECT * FROM Customers
WHERE CustomerID = 32;

--Select all records where the City column has the value 'Berlin' and the PostalCode column has the value 12209.
SELECT * FROM Customers 
WHERE City = 'Berlin'
AND PostalCode = 12209;

--Select all records where the City column has the value 'Berlin' or 'London'.
SELECT * FROM Customers
WHERE City = 'Berlin'
OR City = 'London'

--Write a statement that will select the City column from the Customers table.
SELECT City FROM Customers;

-- Find the sum of the Quantity fields in the OrderDetails database/table
SELECT SUM(Quantity)
FROM OrderDetails;

--Returns the number of records that have the Price set to 18
SELECT COUNT(*)
FROM Products
WHERE Price = 18;

--Selects the record with the highest(max) value of the Price COLUMNS
SELECT MAX(PRICE)
FROM Products;

--Delete all records from the Customers table where the Country value is 'Norway'
DELETE FROM Customers
WHERE Country = 'Norway';

--Delete all records from the Customers table:
DELETE FROM Customers;

-- Update the City column of all records in the Customers table.
UPDATE Customers
SET City = 'Oslo';

--Set the value of the City columns to 'Oslo', but only the ones where the Country column has the value "Norway".
UPDATE Customers
SET City = 'OSLO'
WHERE Country = 'Norway';

--Update the City value and the Country value.
UPDATE Customers
SET City = 'Oslo'
Country = 'Norway'
WHERE CustomerID = 32;

--Select all records from the Customers where the PostalCode column is empty.
SELECT * FROM Customers
WHERE PostaCode IS NULL;

--Select all records from the Customers where the PostalCode is NOT EMPTY_BLOB
SELECT * FROM Customers
WHERE PostalCode IS NOT NULL;

--Write an SQL query to check the current phone number set for your customer:
SELECT * FROM CUSTOMER.PHONE_NR
WHERE CustomerID = 7722124


--Insert a new record in the Customers table.
INSERT INTO Cusomers (
CustomerName,
Address,
City,
PostalCode,
Country	)
VALUES (
'Hekkan Burger',
'Gateveien 15',
'Sandnes',
'4306',
'Norway');

--Select all records from the Customers table, sort the result alphabetically by the column City.
SELECT * FROM Customers
ORDER BY City;

--Select all records from the Customers table, sort the result reversed alphabetically by the column City.
SELECT * FROM Customers
ORDER BY City DESC;

--Select all records from the Customers table, sort the result alphabetically, first by the column Country, then, by the column City.
SELECT * FROM Customers
ORDER BY Country, City;




-- SQL LIKE OPERATOR --

/*
The LIKE operator is used in a WHERE clause to search for a specified pattern in a column.

There are two wildcards often used in conjunction with the LIKE operator:
 The percent sign (%) represents zero, one, or multiple characters
 The underscore sign (_) represents one, single character
 
 Examples:
WHERE CustomerName LIKE 'a%'	Finds any values that start with "a"
WHERE CustomerName LIKE '%a'	Finds any values that end with "a"
WHERE CustomerName LIKE '%or%'	Finds any values that have "or" in any position
WHERE CustomerName LIKE '_r%'	Finds any values that have "r" in the second position
WHERE CustomerName LIKE 'a_%'	Finds any values that start with "a" and are at least 2 characters in length
WHERE CustomerName LIKE 'a__%'	Finds any values that start with "a" and are at least 3 characters in length
WHERE ContactName LIKE 'a%o'	Finds any values that start with "a" and ends with "o"
*/


-- from the Customers database find any entries in the CustomerName field that 			begin with a
SELECT * FROM Customers
WHERE CustomerName LIKE 'a%';


-- from the Customers database find any entries in the CustomerName field that 			end with o
SELECT * FROM Customers
WHERE CustomerName LIKE '%o';

-- from the Customers database find any entries in the CustomerName field that 			start with a and end with o
SELECT * FROM Customers
WHERE CustomerName LIKE 'a%o';

--from the Customer database find any entries in the CustomerName field that 			Do not start with a
SELECT * FROM Customers
WHERE CustomerName NOT LIKE 'a%';

--finds all customers with a CustomerName that 						start with "a" and are at least 3 characters in length
SELECT * FROM Customers
WHERE CustomerName LIKE 'a__%';

--finds all customers with a CustomerName that 					have "or" in any position:
SELECT * FROM Customers
WHERE CustomerName LIKE '%or%';

--Select all records where the value of the City column starts with the letter "a".
SELECT * FROM Customers
WHERE City LIKE 'a%';

--Select all records where the value of the City column contains the letter "a".
SELECT * FROM Customers
WHERE City LIKE '%a%';

--Select all records where the value of the City column starts with letter "a" and ends with the letter "b".
SELECT * FROM Customers
WHERE City LIKE 'a%b';

--Select all records where the value of the City column does NOT start with the letter "a".
SELECT * FROM Customers
WHERE City NOT LIKE 'a%';





/* SQL WildCards */


/* WILDCARD CHARACTERS in MS Acess
*	Represents zero or more characters							bl* 			finds bl, black, blue, and blob
?	Represents a single character								h?t 			finds hot, hat, and hit
[]	Represents any single character within the brackets			h[oa]t 			finds hot and hat, but not hit
!	Represents any character not in the brackets				h[!oa]t 		finds hit, but not hot and hat
-	Represents any single character within the specified range	c[a-b]t 		finds cat and cbt
#	Represents any single numeric character						2#5 			finds 205, 215, 225, 235, 245, 255, 265, 275, 285, and 295
 
 */

/* WILDCARD CHARACTERS IN SQL Server
%	Represents zero or more characters								bl% 			finds bl, black, blue, and blob
_	Represents a single character									h_t 			finds hot, hat, and hit
[]	Represents any single character within the brackets				h[oa]t 			finds hot and hat, but not hit
^	Represents any character not in the brackets					h[^oa]t 		finds hit, but not hot and hat
-	Represents any single character within the specified range		c[a-b]t 		finds cat and cbt

*/


--Select all customers with a City starting with "ber":
SELECT * FROM Customers
WHERE City LIKE 'ber%';

--select all customers with a City containing the pattern "es": 
SELECT * FROM Customers
WHERE City LIKE '%es%';

--select all customers with a City starting with any character, followed by "ondon":
SELECT * FROM Customers
WHERE City LIKE '_ondon';

--select all customers with a City starting with "L", followed by any character, followed by "n", followed by any character, followed by "on":
SELECT * FROM Customers
WHERE City LIKE 'L_n_on';

--Select all records where the second letter of the City is an "a".
SELECT * FROM Customers
WHERE City LIKE '_a%';





--Using the [charlist] Wildcard

--select all customers with a City starting with "b", "s", or "p"
SELECT * FROM Customers
WHERE City LIKE '[bsp]%';

--Select all records where the first letter of the City is an "a" or a "c" or an "s".
SELECT * FROM Customers
WHERE City LIKE '[acs]%';

--select all customers with a City starting with "a", "b", or "c":
SELECT * FROM Customers
WHERE City LIKE '[a-c]%';


--select all customers with a City NOT starting with "b", "s", or "p"
SELECT * FROM Customers
WHERE City LIKE '[!bsp]%';
--OR
SELECT * FROM Customers
WHERE City NOT LIKE '[bsp]%';





-- IN Operator

/* 
The IN operator allows you to specify multiple values in a WHERE clause.
The IN operator is a shorthand for multiple OR conditions
*/ 


--selects all customers that are located in "Germany", "France" or "UK":
SELECT * FROM Customers
WHERE Country IN ('Germany', 'France', 'UK');

--select all customers that are NOT located in "Germany", "France" or "UK"
SELECT * FROM Customers
WHERE Country NOT IN ('Germany', 'France', 'UK');


--select all customers that are from the same countries as the suppliers:
SELECT * FROM Customers
WHERE Country IN (SELECT Country FROM Suppliers);





-- BETWEEN Operator

--selects all products with a price between 10 and 20
SELECT * FROM Products
WHERE Price BETWEEN 10 AND 20;


--display the products outside the range of the previous example, use NOT BETWEEN
SELECT * FROM Products
WHERE Price NOT BETWEEN 10 AND 20;


--IN + BETWEEN
--selects all products with a price between 10 and 20. In addition; do not show products with a CategoryID of 1,2, or 3
SELECT * FROM Products
WHERE Price BETWEEN 10 AND 20
AND CategoryID NOT IN (1,2,3);

--select all products with a ProductName between Carnarvon Tigers and Mozzarella di Giovanni:
SELECT * FROM Products
WHERE ProductName BETWEEN 'Carnarvon Tigers' AND 'Mozzarella di Giovanni'
ORDER BY ProductName;

--selects all products with a ProductName between Carnarvon Tigers and Chef Anton's Cajun Seasoning:
SELECT * FROM Products
WHERE ProductName BETWEEN "Carnarvon Tigers" AND "Chef Anton's Cajun Seasoning"
ORDER BY ProductName;








