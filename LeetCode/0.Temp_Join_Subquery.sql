/*
Write a SQL query that retrieves information from the 'temp' table, including the date, temperature in Fahrenheit,
and the temperature difference from the average temperature across all records. Limit the result to the first 3 rows.
*/

SELECT
l.name AS league,
m.date,
m.home_goal,
m.away_goal
FROM league AS l
    INNER JOIN
        (
        SELECT country_id, date, home_goal, away_goal
        FROM match
        WHERE home_goal > away_goal + 5) AS m
ON l.id = m.country_id
LIMIT 5;


/*

*/

