/* SQL Easy Problems Examples Leetcode */
-----------------------------------------

/* 
LeetCode Problem #???182??? - Duplicate Numbers:
Problem Statement: Write a SQL query to find all numbers that appear at least three times in the Numbers table.
*/
SELECT Num AS ConsecutiveNums
FROM Numbers
GROUP BY Num
HAVING COUNT(*) >= 3;

----------------------------------------------------------------

/* 
LeetCode Problem #???1817??? - Finding the Users Active Minutes:
Problem Statement: You are given the User table with columns user_id and action_date. 
Write a SQL query to find the number of users for each active_minute. 
An active_minute is defined as one user doing an action within that minute.
*/
SELECT active_minute, COUNT(DISTINCT user_id) AS 'count'
FROM (
    SELECT user_id, 
           (TIME_TO_SEC(action_date) - TIME_TO_SEC(MIN(action_date) OVER (PARTITION BY user_id ORDER BY action_date))) / 60 AS active_minute
    FROM User
) AS subquery
GROUP BY active_minute;

----------------------------------------------------------------

/* 
LeetCode Problem #175 - Combine Two Tables:
Problem Statement: Combine two tables, Person and Address, to retrieve a list of people's names along with their city and state. 
If there is no address information for a person, you should still include their name in the result with NULL values for city and state.
*/
SELECT Person.firstName, Person.lastName, Address.city, Address.state 
FROM Person
LEFT JOIN Address
ON Person.personId = Address.personId;

SELECT p.firstName, p.lastName, a.city, a.state
FROM Person p
LEFT JOIN Address a
USING(personId);

----------------------------------------------------------------

/*  sos
LeetCode Problem #176 - Second Highest Salary:
Problem Statement: Write a SQL query to find the second highest salary from the Employee table.
*/
SELECT MAX(salary) AS SecondHighestSalary 
FROM employee 
WHERE salary < (SELECT MAX(salary) FROM employee);

SELECT
(SELECT DISTINCT Salary 
FROM Employee ORDER BY salary DESC 
-- LIMIT 1,1
LIMIT 1 OFFSET 1 ) 
AS SecondHighestSalary;

SELECT MAX(salary) AS SecondHighestSalary 
FROM Employee 
WHERE salary <> (SELECT MAX(salary) FROM Employee) ;

----------------------------------------------------------------

/* sos
LeetCode Problem #177 - Nth Highest Salary:
Problem Statement: Write a SQL query to find the nth highest salary from the Employee table.
Hint: Create a function
*/
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
SET N = N-1;
  RETURN (
      SELECT DISTINCT(salary) 
      FROM Employee 
      ORDER BY salary DESC
      LIMIT 1 OFFSET N
-- LIMIT M, 1: It uses the value of M as the offset and limits the result to just one row. 
-- This effectively retrieves the Nth highest salary.
  );
END

----------------------------------------------------------------

/*   sos
LeetCode Problem #181 - Employees Earning More Than Their Managers:
Problem Statement: Given a table Employee with columns Id, Name, and Salary, 
find the names of employees who earn more than their managers.
*/
SELECT e1.Name AS Employee
FROM Employee e1
JOIN Employee e2 ON e1.ManagerId = e2.Id
WHERE e1.Salary > e2.Salary;

----------------------------------------------------------------

/*  sos
LeetCode Problem #182 - Duplicate Emails:
Problem Statement: Given a table Person with columns Id and Email, write a SQL query to find all duplicate email addresses.
*/
SELECT DISTINCT p1.email as Email
FROM Person p1
WHERE EXISTS (
    SELECT *
    FROM Person p2
    WHERE p1.email = p2.email AND p1.id <> p2.id
);

SELECT DISTINCT(p1.email)
FROM  Person p1, Person p2
WHERE p1.id <> p2.id AND p1.email = p2.email 

SELECT email
FROM Person
GROUP BY email
HAVING COUNT(id) > 1;

SELECT Email
FROM Person
GROUP BY Email
HAVING COUNT(*) > 1;

----------------------------------------------------------------

/* 
LeetCode Problem #183 - Customers Who Never Order:
Problem Statement: Write a SQL query to find all customers who never ordered anything from the Customers and Orders tables.
*/
SELECT Customers.Name AS Customers
FROM Customers
LEFT JOIN Orders 
ON Customers.Id = Orders.CustomerId
WHERE Orders.CustomerId IS NULL;
-- WHERE Orders.Id IS NULL;

----------------------------------------------------------------

/* 
LeetCode Problem #595 - Big Countries:
Problem Statement: There is a table World with columns name, population, and area. 
Write a SQL query to find all the names of countries with an area of more than 3 million and a population of more than 25 million.
*/
SELECT name, population, area
FROM World
WHERE area >= 3000000 OR population >= 25000000

----------------------------------------------------------------

/* sos
LeetCode Problem #608 - Tree Node:
Each node in the tree can be one of three types:
"Leaf": if the node is a leaf node.
"Root": if the node is the root of the tree.
"Inner": If the node is neither a leaf node nor a root node.
Write a solution to report the type of each node in the tree.
Return the result table in any order.
*/
SELECT id, 
CASE
    WHEN p_id IS NULL THEN 'Root'
    WHEN p_id IN (SELECT id FROM tree) AND id IN (SELECT p_id FROM tree) THEN 'Inner'
    ELSE 'Leaf'
END AS type
FROM Tree;

Select id, 
case 
        when p_id is null then 'Root'
        when id in (select p_id from Tree) then 'Inner'
--  It checks if the "id" of the current node is found in the list of "p_id" values from the "Tree" table. 
-- If it is, this node is categorized as 'Inner,' which means it has a parent node (it's not a root), 
-- but it's also a parent itself (it has child nodes).
        else'Leaf'
end as type
from Tree 
-- In SQL, you should use the IS NULL or IS NOT NULL operator to check for null values 
-- because regular comparison operators like = do not work as expected with null values
SELECT id,
       CASE
           WHEN p_id IS NULL THEN 'Root'
           WHEN id IN (SELECT DISTINCT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Inner'
           ELSE 'Leaf'
       END AS type
FROM Tree;

----------------------------------------------------------------

/* 
LeetCode Problem #620 - Not Boring Movies:
Write a solution to report the movies with an odd-numbered ID and a description that is not "boring".
Return the result table ordered by rating in descending order.
*/
SELECT id, movie, description, rating
FROM Cinema
WHERE MOD(id, 2) = 1 AND description != 'boring'
ORDER BY rating DESC;

SELECT * FROM Cinema
WHERE MOD(id, 2) = 1 and description not like 'boring'
order by rating desc;

SELECT id, title, rating
FROM Cinema
WHERE description not like 'boring' and id % 2 <> 0;

----------------------------------------------------------------

/* 
LeetCode Problem #620-2 - Not Boring Movies:
Problem Statement: Write an SQL query to find the id, title, and rating of movies that are not boring. 
A movie is considered boring if its rating is less than 3, or it is not in the list of movies with odd-numbered ID.
*/
SELECT id, title, rating
FROM Cinema
WHERE rating > 3 OR id % 2 <> 0;

----------------------------------------------------------------

/*
LeetCode Problem #627 - Swap Salary:
Write a solution to swap all 'f' and 'm' values (i.e., change all 'f' values to 'm' and vice versa) 
with a single update statement and no intermediate temporary tables.
Note that you must write a single update statement, do not write any select statement for this problem.
*/
UPDATE Salary
SET sex = 
CASE
    WHEN sex = 'm' THEN 'f'
    ELSE 'm'
END;

----------------------------------------------------------------

/* 
LeetCode Problem #627-2 - Swap Salary II:
Problem Statement: Given a table Salary with columns id, employee_id, amount, and bonus, 
write an SQL query to swap the values of amount and bonus for all records where bonus is greater than amount.
*/
UPDATE Salary
SET amount = bonus, bonus = amount
WHERE bonus > amount;



----------------------------------------------------------------

/* 
LeetCode Problem #??585?? - Investments in 2016:
Problem Statement: Write a SQL query to find the total investments for each company for each of the years 2016 and 2017. 
Return the result table in any order.
*/
SELECT
    Company,
    SUM(CASE WHEN Year = 2016 THEN Investment ELSE 0 END) AS '2016',
    SUM(CASE WHEN Year = 2017 THEN Investment ELSE 0 END) AS '2017'
FROM Investments
GROUP BY Company;



----------------------------------------------------------------

/* sos
LeetCode Problem #1484 - Group Sold Products By The Date:
Write a solution to find for each date the number of different products sold and their names.
The sold products names for each date should be sorted lexicographically.
Return the result table ordered by sell_date.
*/
SELECT sell_date, count( DISTINCT product ) as num_sold ,  
GROUP_CONCAT( DISTINCT product order by product ASC separator ',' ) as products
From Activities
GROUP by sell_date
ORDER BY sell_date ASC;

----------------------------------------------------------------

/* sos  
LeetCode Problem #1484-2 - Group Sold Products By The Date:
Problem Statement: Write an SQL query to count the number of products sold and the 
number of distinct customers who bought each product on each day.
*/
SELECT sale_date, product_id,
       COUNT(product_id) AS `total_sold`,
       COUNT(DISTINCT customer_id) AS `total_customers`
FROM Sales
GROUP BY sale_date, product_id;

----------------------------------------------------------------

/* 
LeetCode Problem #??1766?? - Tree Node2:
Problem Statement: Write a SQL query to find the id of all the TreeNode that were visited by the user with id = 1 and p_id = 1. 
Return the result in any order.
*/
SELECT DISTINCT t.id
FROM TreeNode t
JOIN Use u 
ON u.tree_id = t.id
WHERE u.id = 1 AND u.p_id = 1;

----------------------------------------------------------------

/*
LeetCode Problem #??1818?? - Minimum Absolute Sum Difference:
Problem Statement: You are given two integer arrays nums1 and nums2 of the same length. 
Find the minimum value of the absolute sum difference after replacing one element in nums1 with any element in nums2.
*/
SELECT MIN(ABS(SUM(nums1) - SUM(nums2)))
FROM nums1;

----------------------------------------------------------------

/* 

*/

----------------------------------------------------------------

/* 

*/

----------------------------------------------------------------

/* 

*/

----------------------------------------------------------------