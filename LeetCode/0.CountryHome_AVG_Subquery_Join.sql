/*
How can you calculate an average of goals scored in the 2012/2013 season from the season column 
without a filter in the WHERE clause?
*/

/*
What is the average number of home goals scored by each country in the 2012/2013 football season, 
considering data from the 'country' and 'match' tables? Write a SQL query to retrieve this 
information for the top 3 countries.
*/

SELECT 
    c.name AS country,
    avg ( 
        CASE WHEN m.season = '2012/2013'
        THEN m.home_goal END) AS home_avg
FROM country AS c
LEFT JOIN match AS m
ON c.id = m.country_id
GROUP BY c.name
LIMIT 3;



/*
Output:
country     home_avg
Portugal    1.6666666666666667
France      1.4210526315789474
Scotland    1.4782608695652174
*/

