/* SQL Easy Problems Examples Leetcode */
-----------------------------------------

/* 
LeetCode Problem #175 - Combine Two Tables:
Problem Statement: Combine two tables, Person and Address, 
to retrieve a list of people's names along with their city and state. 
If there is no address information for a person, you should still include 
their name in the result with NULL values for city and state.
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

SELECT CASE
    WHEN COUNT(*) = 1 THEN NULL
    ELSE (
        SELECT DISTINCT salary
        FROM Employee
        ORDER BY salary DESC
        LIMIT 1 OFFSET 1
    )
END AS SecondHighestSalary
FROM Employee;


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
Problem Statement: Given a table Person with columns Id and Email, 
write a SQL query to find all duplicate email addresses.
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
Problem Statement: Write a SQL query to find all customers who never ordered 
anything from the Customers and Orders tables.
*/
SELECT Customers.Name AS Customers
FROM Customers
LEFT JOIN Orders 
ON Customers.Id = Orders.CustomerId
WHERE Orders.CustomerId IS NULL;
-- WHERE Orders.Id IS NULL;

----------------------------------------------------------------

/* sos
196. Delete Duplicate Emails
Write a solution to delete all duplicate emails, keeping only one unique email with the smallest id.
For SQL users, please note that you are supposed to write a DELETE statement and not a SELECT one.
For Pandas users, please note that you are supposed to modify Person in place.
After running your script, the answer shown is the Person table. 
The driver will first compile and run your piece of code and then show the Person table. 
The final order of the Person table does not matter.
*/
DELETE e1
FROM Emails e1
JOIN Emails e2
ON e1.email_address = e2.email_address
AND e1.id > e2.id;
-- This additional condition is crucial to eliminate duplicates. 
-- It ensures that we only keep the row with the highest "id" value 
-- within each group of duplicate email addresses. 
-- Rows with lower "id" values are considered duplicates and will be deleted.

----------------------------------------------------------------

/* Hard SOS
LeetCode Problem #569 - Median Employee Salary II:
Problem Statement: Write an SQL query to find the median salary of employees for each company. 
The result table should contain company_id and median_salary, and must be sorted by company_id in ascending order. 
The median salary should be rounded to 2 decimal places.
*/
SELECT Company_id, 
       ROUND(
           IFNULL(
               (CASE 
                    WHEN COUNT(*) % 2 = 1 THEN 
                        (SELECT Salary 
                         FROM Employee AS E2 
                         WHERE E1.Company_id = E2.Company_id 
                         ORDER BY Salary 
                         LIMIT (COUNT(*) + 1) / 2) 
                    ELSE 
                        (SELECT AVG(Salary) 
                         FROM Employee AS E2 
                         WHERE E1.Company_id = E2.Company_id 
                         ORDER BY Salary 
                         LIMIT COUNT(*) / 2, 2) 
               END),
               0.00
           ), 
           2) AS median_salary
FROM Employee AS E1
GROUP BY Company_id
ORDER BY Company_id;


----------------------------------------------------------------

/*  SOS - HARD CMF Premium
LeetCode Problem #579 - Find Cumulative Salary of an Employee:
Problem Statement: Write an SQL query to find the cumulative salary of an employee over a period of time.
*/
SELECT a.employee_id, 
       a.date AS start_date, 
       MIN(b.date) AS end_date, 
       SUM(b.salary) AS salary
FROM Employee AS a, Employee AS b
WHERE a.employee_id = b.employee_id AND b.date >= a.date
GROUP BY a.employee_id, a.date
ORDER BY a.employee_id, a.date;

----------------------------------------------------------------

/* 
LeetCode Problem #595 - Big Countries:
Problem Statement: There is a table World with columns name, population, and area. 
Write a SQL query to find all the names of countries with an area of more 
than 3 million and a population of more than 25 million.
*/
SELECT name, population, area
FROM World
WHERE area >= 3000000 OR population >= 25000000

----------------------------------------------------------------

/* 
LeetCode Problem #595-2? - Big Countries II:
Problem Statement: There is a table World with columns name, population, and area. 
Write a SQL query to find all the names of countries that have a larger population than 
the combined population of all countries in Europe.
*/
SELECT w.name
FROM World w
WHERE w.population > (
    SELECT SUM(population) 
    FROM World 
    WHERE continent = 'Europe'
);

----------------------------------------------------------------

/* 
LeetCode Problem #596 - Classes More Than 5 Students:
Problem Statement: Write an SQL query to find all classes which have more than or equal to 5 students.
*/
SELECT class
FROM courses
GROUP BY class
HAVING COUNT(DISTINCT student) >= 5;
-- The HAVING clause is used to filter the results of grouped data (after grouping and aggregation).

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
LeetCode Problem #620-2? - Not Boring Movies:
Problem Statement: Write an SQL query to find the id, title, 
and rating of movies that are not boring. 
A movie is considered boring if its rating is less than 3, 
or it is not in the list of movies with odd-numbered ID.
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
LeetCode Problem #627-2? - Swap Salary II:
Problem Statement: Given a table Salary with columns id, employee_id, amount, and bonus, 
write an SQL query to swap the values of amount and bonus for all records where bonus is greater than amount.
*/
UPDATE Salary
SET amount = bonus, bonus = amount
WHERE bonus > amount;

----------------------------------------------------------------

/*
LeetCode Problem #627-3? - Swap Salary III:
Problem Statement: Given a table Salary with columns id, employee_id, amount, and bonus, 
write an SQL query to swap the values of amount and bonus for all records where id is an odd number.
*/
UPDATE Salary
SET amount = bonus, bonus = amount
WHERE id % 2 = 1;

----------------------------------------------------------------

/*
LeetCode Problem #1075 - Project Employees I:
Write an SQL query that reports the average experience years of all the employees for each project, rounded to 2 digits.
*/
SELECT p.project_id, ROUND(AVG(e.experience_years),2) AS average_years
FROM Employee e
LEFT JOIN Project p
USING (employee_id)
WHERE project_id IS NOT NULL
GROUP BY p.project_id
ORDER BY project_id;

SELECT p.project_id, ROUND(avg(e.experience_years),2) as average_years
FROM Project p
LEFT JOIN Employee e
on p.employee_id = e.employee_id
group by p.project_id

SELECT project_id, round(sum(experience_years)/count(experience_years),2) as average_years
FROM Project p
JOIN Employee e 
USING(employee_id)
GROUP BY 1;

----------------------------------------------------------------

/*
LeetCode Problem #1075-2? - Project Employees II:
Problem Statement: Write an SQL query to find all the projects that have the most employees.
*/
SELECT project_id
FROM Project
GROUP BY project_id
HAVING COUNT(*) = (
    SELECT COUNT(*) AS max_employees
    FROM Project
    GROUP BY project_id
    ORDER BY max_employees DESC
    LIMIT 1
);

----------------------------------------------------------------

/*  sos
LeetCode Problem #1179 - Reformat Department Table:
Problem Statement: Write an SQL query to reformat the table Department 
to get the result in the format (id, revenue, month), where:
id is the department's id.
month is the month for which the revenue was recorded.
revenue is the revenue for the department and month.
*/
SELECT id,
       MAX(IF(month = 'Jan', revenue, NULL)) AS Jan_revenue,
       MAX(IF(month = 'Feb', revenue, NULL)) AS Feb_revenue,
       MAX(IF(month = 'Mar', revenue, NULL)) AS Mar_revenue,
       MAX(IF(month = 'Apr', revenue, NULL)) AS Apr_revenue,
       MAX(IF(month = 'May', revenue, NULL)) AS May_revenue,
       MAX(IF(month = 'Jun', revenue, NULL)) AS Jun_revenue,
       MAX(IF(month = 'Jul', revenue, NULL)) AS Jul_revenue,
       MAX(IF(month = 'Aug', revenue, NULL)) AS Aug_revenue,
       MAX(IF(month = 'Sep', revenue, NULL)) AS Sep_revenue,
       MAX(IF(month = 'Oct', revenue, NULL)) AS Oct_revenue,
       MAX(IF(month = 'Nov', revenue, NULL)) AS Nov_revenue,
       MAX(IF(month = 'Dec', revenue, NULL)) AS Dec_revenue
FROM Department
GROUP BY id;

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
Leetcode Problem 1978 - Employees Whose Manager Left the Company:
Find the IDs of the employees whose salary is strictly less than $30000 and whose manager left the company. 
When a manager leaves the company, their information is deleted from the Employees table, 
but the reports still have their manager_id set to the manager that left.
Return the result table ordered by employee_id.
Explanation:
The employees with a salary less than $30000 are 1 (Kalel) and 11 (Joziah).
Kalel's manager is employee 11, who is still in the company (Joziah).
Joziah's manager is employee 6, who left the company because there is no row for employee 6 as it was deleted.
*/
SELECT employee_id
FROM Employees
WHERE salary < 30000 
AND manager_id NOT IN (
    SELECT DISTINCT(employee_id) FROM Employees
)
ORDER BY employee_id;

----------------------------------------------------------------

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

/*
LeetCode Problem #?1480?? - Running Sum of 1d Array:
Problem Statement: Given an array nums, write an SQL query to generate a new array 
where ans[i] is the sum of all the nums[j] where 0 <= j <= i.
*/
SELECT id, 
       SUM(num) AS running_sum
FROM RunningSum
GROUP BY id
ORDER BY id;


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

/* HARD SOS
LeetCode Problem #??1785?? - Minimum Elements to Add to Form a Given Sum:
Problem Statement: Write an SQL query to find the minimum number of elements 
that need to be added to an array to form a given sum.
*/
SELECT COUNT(*) AS num_elements
FROM (SELECT x,
             ROW_NUMBER() OVER (ORDER BY x) AS rn
      FROM elements) AS t1
WHERE x <= 3000
AND x >= 0
UNION ALL
SELECT a.x + b.x,
       a.rn + b.rn
FROM t1 AS a, t1 AS b
WHERE a.x + b.x <= 3000
ORDER BY num_elements
LIMIT 1;

----------------------------------------------------------------

/* sos
LeetCode Problem #??1805?? - Number of Different Integers in a String:
Problem Statement: Write an SQL query to find the number of different integers 
in a string containing alphanumeric characters and spaces. 
Alphanumeric characters are preceded and followed by non-alphanumeric characters.
*/
SELECT COUNT(DISTINCT val) AS num
FROM (SELECT DISTINCT REGEXP_SUBSTR(word, '[0-9]+') AS val
      FROM Words) AS temp
WHERE val IS NOT NULL;
-- REGEXP_SUBSTR("abc456xyz789", '[0-9]+') will match "456" 
-- because it's the first sequence of one or more consecutive digits in the string.

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
LeetCode Problem #??1818?? - Minimum Absolute Sum Difference:
Problem Statement: You are given two integer arrays nums1 and nums2 of the same length. 
Find the minimum value of the absolute sum difference after replacing one element in nums1 with any element in nums2.
*/
SELECT MIN(ABS(SUM(nums1) - SUM(nums2)))
FROM nums1;

----------------------------------------------------------------

/* Example 1: nNrgRVIzeHg
Check how many customers we have in each country
*/
SELECT country, COUNT(*)
FROM customers
GROUP BY country
ORDER BY COUNT(*) DESC;
-- if you have an aggregate function in your select statement,
-- as well as a regular non aggregate column you need to use the group by clause

----------------------------------------------------------------

/* Example 2:
Split it also by city
*/
SELECT country, city, COUNT(*)
FROM customers
GROUP BY country, city
ORDER BY COUNT(*) DESC;
-- You also need to include city in your group by clause

----------------------------------------------------------------

/* Example 3:
Filter on your aggregation to 
*/
SELECT country, city, COUNT(*)
FROM customers
GROUP BY country, city
HAVING COUNT(*) > 4
ORDER BY COUNT(*) DESC;

----------------------------------------------------------------

/* Example 4:
Filter to get countries that start with A
*/
SELECT country, city, COUNT(*)
FROM customers
WHERE country_name LIKE 'A%'
GROUP BY country, city
--GROUP BY 1,2
HAVING COUNT(*) > 4
ORDER BY COUNT(*) DESC;

----------------------------------------------------------------

/* Example 5: shorts/0R9JBUfWvkg
Find employees that make less than 30k per year
*/
SELECT empName
FROM employees
GROUP BY empName
HAVING SUM(empSalary) < 30000;
-- HaviHAVINGng clause can contain aggregate functions
-- HAVING goes after the GROUP BY clause, WHERE clause goes before the GROUP BY clause

----------------------------------------------------------------