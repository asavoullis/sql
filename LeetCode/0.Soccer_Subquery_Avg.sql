/*
In a table of soccer matches, which matches have a total number of goals scored more than 3 times the average ? 
Can you determine this using a correlated subquery?
*/

/*
Input:
country_id  date        home_goal   away_goal
10          11/1/08     4           1
20          11/8/08     0           0
*/

-- Reason to use a subquery?
-- Tables cannot be joined due to wanting to create multiple connections
-- subqueries are a powerful tool in SQL that allows for more flexible, modular, complex querying 
-- and data manipulation. They are particularly useful when dealing with scenarios that involve comparisons,
-- aggregations, and dependencies between different sets of data.

SELECT
    m.date,
    m.home_goal,
    m.away_goal
FROM match AS m
WHERE (home_goal + away_goal) >
    (
        SELECT AVG(m1.home_goal + m1.away_goal) * 3
        FROM match AS m1
        WHERE m.country_id = m1.country_id
    )
LIMIT 3;


/*
Output:
date        home_goal   away_goal
2012-12-09  1           7
2013-01-19  2           6
2008-10-29  4           4
*/

