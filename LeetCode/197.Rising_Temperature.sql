-- 197. Rising Temperature
-- https://leetcode.com/problems/rising-temperature/

/*
Table: Weather

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the column with unique values for this table.
This table contains information about the temperature on a certain day.

Write a solution to find all dates' Id with higher temperatures compared to its previous dates (yesterday).
Return the result table in any order.
The result format is in the following example.

Example 1:

Input: 
Weather table:
+----+------------+-------------+
| id | recordDate | temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+

Output: 
+----+
| id |
+----+
| 2  |
| 4  |
+----+
Explanation: 
In 2015-01-02, the temperature was higher than the previous day (10 -> 25).
In 2015-01-04, the temperature was higher than the previous day (20 -> 30).

*/

SELECT w1.id
FROM Weather w1
JOIN Weather w2 
ON w1.recordDate = DATE_ADD(w2.recordDate, INTERVAL 1 DAY)
WHERE w1.temperature > w2.temperature;

SELECT today.id
FROM Weather AS today
INNER JOIN Weather AS yesterday
ON DATE_ADD(yesterday.recordDate, INTERVAL 1 DAY)= today.recordDate
WHERE today.temperature > yesterday.temperature


SELECT a.id
FROM Weather a
INNER JOIN Weather b
ON TO_DAYS(a.recordDate) = TO_DAYS(b.recordDate) + 1
WHERE a.temperature > b.temperature

SELECT w1.id
FROM Weather w1, Weather w2
WHERE DATEDIFF(w1.recordDate, w2.recordDate) = 1 
AND w1.temperature > w2.temperature;

SELECT id FROM
(
    SELECT w1.id, w1.recordDate, w1.temperature, w2.temperature AS prev_temp
    FROM Weather w1
    LEFT JOIN Weather w2 on w1.recordDate = SUBDATE(w2.recordDate, -1)
) as c
WHERE temperature > prev_temp;
