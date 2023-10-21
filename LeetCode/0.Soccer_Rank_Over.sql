/*
Can you rank soccer matches in the 2011/2012 season from highest to lowest by total of home_goal and away_goal?
*/

/*
Input:
date        home_goal   away_goal
11/1/08     4           1
3/21/09     2           0
*/

SELECT date,
    home_goal, away_goal,
    RANK() OVER (ORDER BY home_goal + away_goal DESC) AS ranking
FROM match
WHERE season = '2011/2012'
LIMIT 5;


/*
Output:
date        home_goal   away_goal   ranking
2012-03-10  7           1           1
2011-12-09  5           2           2
2012-05-12  2           5           2
2011-10-23  3           4           2
2011-12-19  3           4           2
*/

