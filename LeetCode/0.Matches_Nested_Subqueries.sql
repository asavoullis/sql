-- How do you set up a nested subquery to count the number of matches in each season with 2 times the average goals scored?

/*
Output:
season      count
2012/2013   3
2010/2011   1
2013/2014   2
*/

SELECT season, COUNT(id)
FROM (
SELECT season, id
    FROM match
    WHERE home_goal > (
        SELECT AVG(home_goal + away_goal) * 2
        FROM match)) AS abc
GROUP BY season
LIMIT 3;
