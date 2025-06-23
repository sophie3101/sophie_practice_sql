DROP TABLE IF EXISTS PlayerScores;


CREATE TEMP TABLE PlayerScores
(
PlayerA  INTEGER,
PlayerB  INTEGER,
Score    INTEGER NOT NULL,
PRIMARY KEY (PlayerA, PlayerB)
);


INSERT INTO PlayerScores (PlayerA, PlayerB, Score) VALUES
(1001,2002,150),(3003,4004,15),(4004,3003,125);

WITH cte AS (
SELECT 
CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END AS Player1,
CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END  AS Player2,
Score
FROM PlayerScores )

SELECT Player1, Player2, SUM(score)
FROM cte 
GROUP BY player1,player2
