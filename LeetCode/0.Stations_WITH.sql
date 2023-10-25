-- CTE = Common Table Expressions

/*
Write a SQL query that utilizes Common Table Expressions (CTEs) to find the start and end stations 
for bike trips recorded in the 'trip' table. The query should calculate the count of trips starting 
at each station (labeled as 'starts') and the count of trips ending at each station (labeled as 'ends'). 
Finally, the query should display the station name, the number of starts, and the number of ends, 
ordered by the number of starts in descending order.
*/

/*
Are the most popular stations to start a trip also the most popular stations to end a trip?
Can you set up and join two CTEs to get this result?
*/

/*
Output:
start_date  start_station   end_date    end_station
8/29/13     5th at Howard   8/29/13     5th at Howard
8/29/13     South Van Ness  8/29/13     Powell Street BART

*/

WITH s AS (
    SELECT start_station,
        COUNT(start_date) AS st
    FROM trip
    GROUP BY start_station),
e AS (
    SELECT end_station,
        COUNT(end_date) AS endss
    FROM trip
    GROUP BY end_station)
SELECT
    s.start_station AS station,
    s.st AS starts,
    e.endss AS ends
FROM s
INNER JOIN e
ON s.start_station = e.end_station
ORDER BY starts DESC
