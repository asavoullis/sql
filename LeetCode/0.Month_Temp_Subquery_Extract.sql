/*
You have a table of weather data in San Francisco with 1 row per day containing information 
about weather parameters such as temperature, humidity, and rain.
*/

/*
Write a SQL query to extract the average maximum temperature for each month from the 'weather' table. 
The query should return the month and the corresponding average temperature, ordered by the average 
temperature in descending order. Limit the result to the top 3 months with the highest average temperatures.
*/

SELECT
    mo, avg_temp
FROM (
    SELECT mo,
    AVG(max_temp_f) AS avg_temp
    FROM 
    (
        SELECT
        EXTRACT(MONTH FROM date) AS mo,
        max_temp_f
        FROM weather) s1
    GROUP BY mo) s
ORDER BY avg_temp DESC
LIMIT 3;

/*
Output:
mo  avg_temp
12  79.9411764705882353
11  75.0000000000000000
10  69.7741935483870968
*/

