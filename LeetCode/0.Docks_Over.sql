-- Can you create a simple window function to calculate the overall count of bicycle docks at a station without grouping the result?

/*
Input:
name        docks
San Jose D  27
San Jose C  15
Santa Clar  11
*/

SELECT
    name,
    docks,
    COUNT(docks)OVER()AS total_docks
FROM stations
LIMIT 5;

/*
name            docks   total_docks
San Jose D      27      70
San Jose C      15      70
Santa Clar      11      70
Adobe on A      19      70
San Pedro       15      70
*/