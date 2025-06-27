
DROP TABLE IF EXISTS PlayerScores;


CREATE TEMP TABLE PlayerScores
(
PlayerID  INTEGER PRIMARY KEY,
Score     INTEGER NOT NULL
);


INSERT INTO PlayerScores (PlayerID, Score) VALUES
(1001,2343),(2002,9432),
(3003,6548),(4004,1054),
(5005,6832);

--solution1
SELECT 
	NTILE(2) OVER(ORDER BY Score DESC),
PlayerID,
Score
FROM PlayerScores

--Solution 2
SELECT 
	CASE 
		WHEN Score >= median_num THEN 1
		ELSE 2
	END AS quartile,
PlayerID,
Score
FROM PlayerScores, (SELECT PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY Score) AS median_num FROM PlayerScores p2)
ORDER BY quartile