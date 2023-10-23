/* Are the most popular stations to start a trip also the most popular stations to
end a trip? Can you set up and join a CTE to the trip table to get this result?
Here is a preview of the trip table.
*/

/*
Input:
start_date  start_station   end_date   end_station
8/29/13     5th at Howard   8/29/13     5th at Howard
8/29/13     South Van Ness  8/29/13     Powell Street BART
*/

WITH s AS (
    SELECT
        start_station,
        COUNT(start_date) AS starts
        FROM trip
        GROUP BY start_station)
    SELECT
        t.end_station AS station,
        COUNT(t.end_date) AS ends,
        s.starts
        FROM trip AS t
INNER JOIN s
ON t.end_station = s.start_station
GROUP BY station, starts
LIMIT 3;


/*
Output:
station                                     ends    starts
Grant Avenue at Columbus Avenue             93      134
Civic Center BART (7th at Market)           155     148
San Francisco Caltrain 2 (330 Townsend)     356     299
*/


