Player with Longest Streak

You are given a table of tennis players and their matches that they could either win (W) or lose (L). Find the longest streak of wins. A streak is a set of consecutive won matches of one player. The streak ends once a player loses their next match. Output the ID of the player or players and the length of the streak.

```
WITH cte AS (
SELECT player_id, match_result,
       ROW_NUMBER() OVER (
           PARTITION BY player_id 
           ORDER BY 
             CASE WHEN match_result ='W' THEN 0 ELSE 1 END,
             match_date
       ) AS row_num,
       RANK() OVER(PARTITION BY player_id ORDER BY match_date DESC) as rnk
FROM players_results

), diff_cte AS 
(
SELECT player_id, 
rnk + row_num AS diff
FROM cte
WHERE match_result='W'
), rank_cte AS (
SELECT player_id, COUNT(diff) AS streak_length,
RANK()OVER(ORDER BY COUNT(diff) DESC) as streak_rank
FROM diff_cte
GROUP BY player_id, diff
)
SELECT player_id, streak_length
FROM rank_cte
WHERE streak_rank=1
```