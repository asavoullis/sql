/*
Write a SQL query to find the top 5 teams with the highest average win margin for matches where Team 1 is the 
winner. Include the team name and the rounded mean win margin in the result set. Ensure the results are ordered in 
descending order of the mean win margin.
*/

SELECT t.name AS team,
       ROUND(AVG(m.win_margin), 2) AS mean_win_margin
FROM match AS m
LEFT JOIN team AS t 
ON m.team_id = t.id
WHERE m.match_winner = 1
GROUP BY t.name
ORDER BY mean_win_margin DESC
LIMIT 5;

/*
Output
team							mean_win_margin
Chennai Super Kings				22.72
Royal Challengers Bangalore		20.68
Mumbai Indians					19.94
Rajasthan Royals				17.28
Deccan Chargers					17.00
*/