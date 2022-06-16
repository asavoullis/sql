/*
A row is known as a record

ORDER BY sorts results according to the values of one or more COLUMNS

In a BETWEEN clause, both the beginning and the end values are included in the results 
(a shorthand for filtering values within a specified range

The LIKE clause is used in a WHERE clause to search for a pattern in a COLUMN

AS is a keyword used to alias 

use a subquery to compare an individual value to an aggregate value
*/


-- duplicate (copy) a table
create table `client`.adwords
select * from `client`.s_account

-- will give you 1 (returns int quotient)
SELECT (4 / 3);

-- You can return more precise results by adding decimal places to the numbers, this will give you 1.333
SELECT (4.0 / 3.0);

-- Counts all the unique values of column_name1
SELECT COUNT( DISTINCT column_name1) FROM DB;

-- will return 5 rows with columns name, user_number, they can be null as well.
SELECT name, user_number FROM companies
WHERE employee_number <> 300
LIMIT 5;

-- returns all countries that have count of 1 (counts countries)
SELECT Country, COUNT(*) FROM companies 
GROUP BY Country 
HAVING COUNT(Country) = 1;

-- the IN operator makes it easier and quicker to specify multiple OR conditions
SELECT * FROM Customers
WHERE Country IN ('Germany', 'France', 'UK');

--The following SQL statement selects all customers that are from the same countries as the suppliers
SELECT * FROM Customers
WHERE Country IN (SELECT Country FROM Suppliers);

-- creating a new column with the name max_duration
SELECT MAX(duration) AS max_duration FROM films

-- combining aggregate functions using arithmetic operators and using Alias for the results
-- result is a single column, duration_diff, with a single value calculated from the range of the duration values (max -min values)
SELECT MAX(duration) - MIN(duration) AS duration_diff FROM movies;

-- creates 2 new columns, max_budget and max_duration with the max values of each COLUMNS
SELECT  
 MAX(budget) AS max_budget,
 MAX(duration) AS max_duration
 FROM movies;

-- will return a single column, percentage_name with a value 100.000000
SELECT COUNT(name) * 100.0 / count(*) AS percentage_name FROM companies

-- Aggregations can not be used with the WHERE clause. You can use the HAVING clause to filter the results of an aggregate function, like AVG()or SUM(). The HAVING clause must be listed after GROUP BY. 
-- Having clasuse is used to filter based on the result of an aggregate function
SELECT founding_year, COUNT(*)
FROM companies
GROUP BY founding_year
 HAVING COUNT(founding_year) > 1;

-- alternative of average (using 2 columns)
SELECT SUM(user_number) / COUNT(user_number) AS avg_number FROM companies
WHERE country = 'USA';

-- the % wildcard acts as a placeholder for other values and matches 0,1 or many characters.
-- you can use the 'A%' string pattern to look for values taht start with the capital letter 'A'
SELECT name FROM people
WHERE name LIKE 'A%';

-- The NOT LIKE keyword returns records that do not match a pattern. Will return all values that do not start wtih an 'A'.
SELECT name FROM people
WHERE name NOT LIKE 'A%';

-- the _ wildcard matches a single character. Will return values that have 'n' as the seocnd character and one character in front of 'n'.
SELECT name FROM people
WHERE name LIKE '_n%';

-- returns the number of movies released after the year 2000
SELECT COUNT(*) FROM films WHERE release_year > 2000

-- The ORDER BY keyword is used to sort the result-set(multiple columns) in ascending or descending order.
--The ORDER BY keyword sorts the records in ascending order by default. To sort the records in descending order, use the DESC keyword.
SELECT * FROM Customers
ORDER BY Country DESC;

-- A GROUP BY clause can be added after the WHERE clause to group a result by one or more COLUMNS
-- where language is not <> Italian
SELECT language, SUM(budget) FROM movies
WHERE language <> 'Italian'
GROUP BY language;

-- After GROUP BY, an ORDER BY clause can be added to group the results, perform calculations on them and order them.
-- GROUP BY goes BEFORE ORDER BY  ( ORDER BY GOES LAST ALWAYS)
SELECT language, SUM(budget) FROM movies
WHERE language <> 'Italian'
GROUP BY language
ORDER BY SUM(budget);

-- After the GROUP BY, before the ORDER BY, a HAVING clause can be included to group the results, filter based on the result of an aggregate function, and order the results.
SELECT language, SUM(budget) FROM movies
WHERE language <> 'Italian'
GROUP BY language
HAVING SUM(budget) > 5000000
ORDER BY SUM(budget);

--  The GROUP BY statement groups rows that have the same values into summary rows, like "find the number of customers in each country".
-- The GROUP BY statement is often used with aggregate functions (COUNT(), MAX(), MIN(), SUM(), AVG()) to group the result or set by one or more columns.
select conversionslaton, count(*) from `client_`.aav_ca_copy
GROUP BY conversionslaton 
Having count(conversionslaton) > 1;

-- The following SQL statement lists the number of orders sent by each shipper
SELECT Shippers.ShipperName, COUNT(Orders.OrderID) AS NumberOfOrders FROM Orders
LEFT JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID
GROUP BY ShipperName;

-- List the number of customers in each country
SELECT Count(Customer ID), Country FROM Customers
ORDER BY Country;

-- The following SQL statement lists the number of customers in each country, sorted high to low
SELECT COUNT(CustomerID), Country FROM Customers
GROUP BY Country
ORDER BY COUNT(CustomerID) DESC;

-- this query creates a new column and sets the values in it 
-- you get null values by default if you don't have else clause in your case statement
select *,
CASE
-- takes 3 values from campaign_id column and sets them as Individual_campaigns
when campaign_id IN ( c_id_1, c_id_2, c_id_3) then "Individual_campaigns"
-- takes the value of c_id_total and sets it as Combined_campaigns
when campaign_id IN (c_id_total) then "Combined_campaigns"
-- creates a new column and sets it as T_3CO/I_BAU
end as "T_3CO/I_BAU"
from `client_archive`.aav_ca_copy
-- Filter the campaign_id column to just the values we want to check
where campaign_id IN (c_id_1, c_id_2, c_id_3, c_id_total);

-- selects columns from different tables 
SELECT Shippers.ShipperName, COUNT(Orders.OrderID) AS NumberOfOrders FROM Orders
LEFT JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID
GROUP BY ShipperName;

-- 3 columns player_name, height and height_diff calculated by subtracting height from the average height using a sub query
SELECT player_name, height, 
height - (SELECT AVG(height) FROM players) AS height_diff 
FROM players
-- another sub query 
WHERE height = (SELECT MAX(height) FROM players)
LIMIT 5;

-- GROUP BY groups the results by 1 or many COLUMNS
SELECT season, COUNT(id)
FROM (SELECT season, id FROM match
 WHERE home_goal > (
  SELECT AVG( home_goal + away_goal) * 2
  FROM match)) AS abc
GROUP BY season
LIMIT 3;
	
-- filter the query for player_id's taller than 175 
-- use subqueries when tables cannot be joined due to wanting to create multiple connections
SELECT player_name, penalties FROM players
WHERE player_id IN (SELECT player_id FROM players WHERE height > 175)
LIMIT 5;

-- use a correlated subquery to find which matches have a total number of goals scored more than 3 times the average
SELECT m.date, m.home_goal, m.away_goal FROM match AS m 
WHERE (home_goal + away_goal) > (SELECT AVG(m1.home_goal + m1.away_goal) * 3 FROM match AS M1 WHERE m.country_id = m1.country_id);
LIMIT 3;

-- make two columns and name them and in each column we have the max number of that column
SELECT max(organizationid) AS max_org , MAX(conversionslaton) AS max_conv FROM `client_`.aav_ca_copy;

-- we get 2 columns back and 5 rows in each with results greater than the release_year 2000 and grouped by release_year
SELECT release_year, MIN(gross) AS min_gross FROM films 
WHERE release_year > 2000 
GROUP BY release_year
LIMIT 5;

-- we get 2 columns ordered by title descending
SELECT title, duration FROM FILMS 
ORDER BY title DESC
LIMIT 5;

-- get 2 columns with results from founding_year between 2010 and 2012
SELECT name, founding_year FROM companies
WHERE founding_year BETWEEN 2010 AND 2012;

-- Find all PG-certifled films that were released in the USA or the UK
SELECT title, certification, country FROM films
WHERE certification = 'PG' AND ( country = 'USA' OR country = 'UK')

-- returns 1.66667
SELECT (5.0 / 3.0) AS RESULT;

-- same thing as average
SELECT SUM(employee_number) / COUNT(employee_number) AS average_number FROM companies;

-- find unique roles
SELECT COUNT(DISTINCT role) AS unique_roles FROM roles;

-- find the records for all Spanish films released before 2000
SELECT title, f_language FROM films 
WHERE language = 'Spanish'
AND release_year < 2000
LIMIT 5;

-- 
SELECT release_year, COUNT(*) FROM films 
GROUP BY release_year 
ORDER BY COUNT(*)
Limit 5;

-- select 2 columns and sort them by the num_votes from low to high (downwards)
SELECT film_id, num_votes FROM reviews
ORDER BY num_votes
LIMIT 5;

--
SELECT title, release_year FROM films
WHERE release_year = 1994
OR release_year = 2000
LIMIT 5;

-- get the number of companies that have more than 500 employees
SELECT COUNT(*) FROM companies 
WHERE employee_numbe > 500;

-- counts all the rows in the people TABLE
SELECT COUNT(*) FROM people;

-- get the title and release year of movies that have been released in or after the year 2000
SELECT title, release_year FROM films
WHERE  release_year > 2000
LIMIT 5;

-- orders them first by user_number and then by name
SELECT name, user_number FROM companies
ORDER BY user_number, name
LIMIT 5;

-- get the films in Spanish, French or Italian
SELECT title, language
FROM films
WHERE language IN ('Spanish', 'French', 'Italian')

--
SELECT release_year, COUNT(*) FROM films
GROUP BY release_year ORDER BY COUNT(*) DESC
LIMIT 5;

-- get the number of all records from a table
SELECT * FROM people

-- 
SELECT
  p1.date,
  p1.player_name AS home_pl1,
  p2.player_name AS home_pl2
FROM ( 
  SELECT m.id, p.player_name, m.date  
  FROM match AS m
  INNER JOIN players AS p 
ON m.home_player_1 = p.player_id) AS p1
INNER JOIN (
  SELECT m.id, p.player_name
  FROM match AS m
  INNER JOIN players AS p 
  ON m.home_player_2 = p.player_id
  ) AS p2
ON p1.id = p2.id
LIMIT 5;

-- create a crosstab, 
SELECT defensive_work_rate,
COUNT(CASE WHEN preferred_foot = 'left' THEN player_id END) AS left,
COUNT (CASE WHEN preferred_foot = 'right' THEN player_id END) AS right
FROM players
GROUP BY defensive_work_rate;

-- get 2 columns but results are filtered by playername that need to contain 
SELECT player_name, free_kick_accuracy FROM players
WHERE player_name IN (SELECT player_name FROM players WHERE player_name LIKE 'Andre%')

-- returns 2 columns with results that contain the word Mediabrands in any position in the rows of the organizationname column
select organizationname, tapthroughrate from `client_archive`.aav_ca_copy
where organizationname LIKE '%Mediabrands%'
ORDER BY tapthroughrate DESC;

-- using case categorize the players as above or below average
SELECT player_name 
CASE
  WHEN height <= 178 THEN 'Below avg'
  ELSE 'Above avg' END AS height_cat
FROM players;

--
SELECT l.name AS league, m.date, m.home_goal, m.away_goal FROM league AS l
INNER JOIN 
(SELECT country_id, date, home_goal, away_goal FROM match_db 
WHERE home_goal > away_goal + 5) AS m
ON l.id = m.country_id;

-- The avg European male is 178 cm, with a std of 10 cm
--find all the players that are 1 std taller than average 
SELECT player_name, height,
CASE WHEN  height > 188 THEN 'Tall'
      ELSE 'Not Tall' END AS height_category
FROM players
WHERE height > 188;

-- write a query to start identifying the first 2 home team players
SELECT
  p1.date,
  p1.player_name AS home_pl1,
  p2.player_name AS home_pl2
FROM (
SELECT m.id, p.player_name, m.date
  FROM match AS m
  INNER JOIN players AS p 
ON m.home_player_1 = p.player_id
) AS p1
INNER JOIN (
  SELECT m.id, p.player_name
  FROM match AS m
  INNER JOIN players AS p 
ON m.home_player_2 = p.player_id
) AS p2
ON p1.id = p2.id
LIMIT 5;

--
SELECT id, date,
CASE WHEN
 h_goal > a_goal THEN 'Home Win'
    WHEN h_goal = a_goal THEN 'Tie'
    WHEN h_goal < a_goal THEN
CASE WHEN
 a_goal - h_goal < 2 THEN '<2'
        WHEN a_goal - h_goal >= 2 THEN '2+' 
END
END
 AS diff
FROM matches
LIMIT 5;

-- use a nested subquery in FROM to extract the two hottest months from a data set of weather in San Francisco
SELECT mo, mean_high
FROM ( 
  SELECT mo, AVG(max_temp_f) AS mean_high
  FROM ( SELECT
     EXTRACT(MONTH FROM date) AS mo, max_temp_f
    FROM weather) AS s
  GROUP BY mo) AS s1
ORDER BY mean_high DESC
LIMIT 2;

-- italy's country code is 10257. Which seasons are being identified in the case statement to determine Italy's total goals scored
SELECT season,
 SUM(CASE WHEN season = '2010/2011' 
     OR season = '2012/2013' 
     THEN home_goal END) AS italy_home_goals
FROM match
WHERE country_id = 10257
GROUP BY season;

-- set up and join a CTE to the trip table to get the following results
WITH s AS
(SELECT start_station, COUNT(start_date) AS starts FROM trip
 GROUP BY start_station)
SELECT t.end_station AS station, COUNT(t.end_date) AS ends, s.starts FROM trip AS t
INNER JOIN s
ON t.end_station = s.start_station
GROUP BY station, starts
LIMIT 3;

-- get the results using a case 
SELECT month, AVG(CASE WHEN max_wind > 15 THEN 1 ELSE 0 END) AS windy FROM temp 
GROUP BY zip_code

-- use a window function to calculate a partitioned average temperature for each zip code
SELECT
  date,
  zip_code,
  max_temp_f,
AVG(max_temp_f)
OVER
(PARTITION BY zip_code)
 AS zip_avg
FROM weather
ORDER BY max_temp_f DESC;

-- create a simple window function to calculate the overall count of bicycle docks at a station without grouping the results
SELECT 
 name,
 docks,
COUNT(docks)
OVER()
AS total_docks
FROM stations;

-- for each station, what is the difference between the number of rides started at the station and the number of rides that ended at the station?
SELECT start_station, COUNT(start_station) AS start_trips, 
  COUNT(start_station) - (SELECT COUNT(*)
    FROM trip AS t1
	WHERE t.start_station = 
	  t1.end_station) AS trips_diff
FROM trip AS t
GROUP BY start_station
ORDER BY start_station DESC;

--


--


--


--


--


--


--


--


--


--


--

