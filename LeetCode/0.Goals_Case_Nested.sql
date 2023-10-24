-- Case statements can also be nested

/*
What happens if you exclude the clause from your statement?
You get NULL values by default
*/

/*
Output:
+------------+------------+----------+
| id         | date       | diff     |
+------------+------------+----------+
| 10         | 2008-11-01 | Home Win |
| 20         | 2008-11-02 | Tie      |
| 30         | 2008-11-03 | Tie      |
| 40         | 2008-11-04 | Home Win |
| 50         | 2008-12-15 | 2+       |
| 60         | 2008-12-16 | <2       |
+------------+------------+----------+
*/

SELECT id, date,
CASE WHEN h_goal > a_goal THEN 'Home Win'
    WHEN h_goal = a_goal THEN 'Tie'
    WHEN h_goal < a_goal THEN
CASE WHEN a_goal - h_goal < 2 THEN '<2'
    WHEN a_goal - h_goal >= 2 THEN '2+'
END END AS diff
FROM matches
LIMIT 6;