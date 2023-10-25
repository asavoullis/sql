-- Write me a query that retrieves data about weather in San Francisco. 
-- Retrieve destination location, number of trips at each location and average trip duration


SELECT start_station,
COUNT(*) AS trips, 
AVG(duration) AS avg_trip_duration
FROM (
    SELECT start_station, duration
    FROM trip
        WHERE start_date > '2014-01-01') AS s GROUP BY start_station
LIMIT 3;


/*
Output:
start_station               trips   avg_trip_duration
Santa Clara at Almaden      37      647.6756756756756757
Spear at Folsom             97      653.4742268041237113
Evelyn Park and Ride        19      553.3684210526315789
*/



