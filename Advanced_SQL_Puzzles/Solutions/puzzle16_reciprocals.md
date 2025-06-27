You work for a software company that released a 2-player game and you need to tally the scores.
Given the following table, write an SQL statement to determine the reciprocals and calculate their
aggregate score.
In the data below, players 3003 and 4004 have two valid entries, but their scores need to be aggregated
together

| Player A | Player B | Score |
| -------- | -------- | ----- |
| 1001     | 2002     | 150   |
| 3003     | 4004     | 15    |
| 4004     | 3003     | 125   |

EXPECTED

| Player A | Player B | Score |
| -------- | -------- | ----- |
| 1001     | 2002     | 150   |
| 3003     | 4004     | 140   |

SCHEMA

```DROP TABLE IF EXISTS PlayerScores;
CREATE TEMP TABLE PlayerScores
(
PlayerA  INTEGER,
PlayerB  INTEGER,
Score    INTEGER NOT NULL,
PRIMARY KEY (PlayerA, PlayerB)
);
INSERT INTO PlayerScores (PlayerA, PlayerB, Score) VALUES
(1001,2002,150),(3003,4004,15),(4004,3003,125);
```

SOLUTION

```
WITH cte AS (
SELECT
CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END AS Player1,
CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END  AS Player2,
Score
FROM PlayerScores )

SELECT Player1, Player2, SUM(score)
FROM cte
GROUP BY player1,player2
```
