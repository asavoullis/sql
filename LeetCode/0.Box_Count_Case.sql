-- Can you use a statement to create a crosstab? The following query compares player attacking rates to their preferred foot used in soccer matches.


/*
Input:
name        docks
San Jose D  27
San Jose C  15
Santa Clar  11
*/

SELECT defensive_work_rate,
COUNT(CASE WHEN preferred_foot = 'left'
    THEN player_id END) AS left,
COUNT(CASE WHEN preferred_foot = 'right'
    THEN player_id END) AS right
FROM players
GROUP BY defensive_work_rate;

/*
Output:
defensive_work_rate     left    right
medium                  406     1120
high                    74      304
low                     71      199
*/

