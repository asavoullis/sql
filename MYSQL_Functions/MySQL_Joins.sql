---------------- MYSQL  JOINS -----------------


/*
1 Inner, left and right joins
2 Self-join and Cross-join
3 UNION and UNION ALL keywords.
*/

----------------------------------------------------------------
USE bookstore;

SELECT orderinfo.itemid customer.customername
FROM orderinfo
INNER JOIN customer
ON orderinfo.customerid = customer.customerid;


SELECT o.itemid c.customername
FROM orderinfo o
INNER JOIN customer c
ON o.customerid = c.customerid;


SELECT a.authorname i.booktitle
FROM author a
INNER JOIN item i
ON a.authorid = i.authorid;

-------------------------------------------------------------------
SELECT i.booktitle, a.authorname
FROM items i
LEFT JOIN author a
USING (authorid)
ORDER BY i.booktitle;


SELECT c.customername, o.itemid
FROM customer c
LEFT JOIN orderinfo o
ON o.customerid = c.customerid
ORDER BY c.customername;


SELECT c.customername, o.itemid
FROM customer AS c
RIGHT JOIN orderinfo AS o
ON o.customerid = c.customerid
ORDER BY c.customername;

----------------------------------------------------
-- SELF and CROSS JOIN

SELECT e.firstname AS EmployeeName, em.firstname AS ManagerName
FROM employees AS e
INNER JOIN employees AS em
ON e.managerid = em.managerid
ORDER BY c.customername;


-- All results are returned 
-- But each row is multiplied 
SELECT * 
FROM item
CROSS JOIN author;

----------------------------------------------------------------
SELECT a.authorname, i.booktitle
FROM author a
INNER JOIN items i
ON a.authorid = i.authorid;

-----------------------------------------------------------------
-- UNION

SELECT * FROM supplier;

-- doesn't return duplicates (only unique ones)
SELECT city FROM customer
UNION
SELECT city FROM supplier
ORDER BY city;

-- brings all the results
SELECT city FROM customer
UNION ALL
SELECT city FROM supplier
ORDER BY city;



SELECT customername FROM customer
UNION 
SELECT firstname FROM employees
ORDER BY customername;

------------------------------------------------------------


--- QUIZ ---
/*
	1.What is meant by an inner join? 
An inner join selects all the records that have matching values in both tables.

	2.What is a left join?
The left join is a join that returns all the rows from the left table, with the matching rows in the right table.

	3.What is a self join?
The self-join is where a table joins to itself and is used when a table is referencing itself.

	4.What is a cross-join?
A cross-join is where a result set is produced which is the number of rows in the first table multiplied by the number of rows in the second table.
*/