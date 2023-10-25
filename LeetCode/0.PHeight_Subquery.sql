-- What is the correct way to use a subquery to filter the query for player_id s taller than 175cm?

/*
Which of the following is a reason for using a subquery in the SELECT statement?
Comparing an individual value to an aggregate value
*/

/*
Input:
--players
player_name     player_id   height  penalties
Khadare Abdou   181220      175.26  64
Lukas Zelenka   30404       175.26  7
*/

SELECT player_name, penalties
FROM players
WHERE player_id IN (
SELECT player_id
    FROM players
WHERE height > 175 )
LIMIT 5;
