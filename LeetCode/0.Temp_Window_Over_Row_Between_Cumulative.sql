/*
Can you use a statement inside a window function to calculate a running total of hot days (75F or higher)?

Compose a SQL query to analyze temperature data stored in the 'temp' table. 
The query should retrieve the date and temperature in Fahrenheit from the 'temp' table, 
and for each row, calculate the cumulative count of days where the temperature is greater than 75°F. 
The result should be limited to the first 5 rows and ordered by date.
*/

/*
Input:
date        temp_f
10/14/13    77
10/15/13    80
*/

-- What is the purpose of a window function in SQL?
-- To perform calculations based on a result set, or a window, of data

SELECT
  date,
  temp_f,
COUNT
(CASE WHEN temp_f > 75 THEN 1 END)
-- This is a window function that specifies the window over which the count is calculated.
-- Defines the window frame as starting from the beginning of the result set and ending at the current row. 
-- This means that the count is cumulative, considering all preceding rows up to the current row.
OVER (ORDER BY date
ROWS BETWEEN
UNBOUNDED PRECEDING
    AND CURRENT ROW) hot_days
FROM temp
LIMIT 5;

/*
date        temp_f  hot_days
2013-10-01  69      0
2013-10-02  69      0
2013-10-03  70      0
2013-10-04  76      1
2013-10-05  80      2
*/