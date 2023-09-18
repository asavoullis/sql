-- Datacamp SQL for Joining Data 1

/*
Question
Were matches played before or after January 1st, 2010? Here's a preview of the season and match tables: 
-- season
id    season_year
 1    2008

-- match
id    season_id
335987    1

*/

SELECT m.id AS match,
 s.season_year < 2010 
 'before 2010-01-01' 
 'after 2010-01-01' END 
	AS time
FROM match AS m
INNER JOIN season AS s
	ON m.season_id = s.id
LIMIT 3;

/*
Output
match 		time
392186		before 2010-01-01
392187		before 2010-01-01
392188		before 2010-01-01
*/