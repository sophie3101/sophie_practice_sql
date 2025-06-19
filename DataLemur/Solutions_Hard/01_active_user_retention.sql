--my method
WITH cte AS (
SELECT user_id, event_type, EXTRACT(MONTH FROM event_date) AS month
FROM user_actions
)


SELECT current.month, COUNT(distinct current.user_id) AS monthly_active_users
FROM cte AS current
JOIN cte AS previous ON current.user_id = previous.user_id AND current.month=previous.month+1
WHERE current.event_type <> previous.event_type AND current.month=7
GROUP BY current.month

--datalemur method
SELECT 
  EXTRACT(MONTH FROM curr_month.event_date) AS mth, 
  COUNT(DISTINCT curr_month.user_id) AS monthly_active_users 
FROM user_actions AS curr_month
WHERE EXISTS (
  SELECT last_month.user_id 
  FROM user_actions AS last_month
  WHERE last_month.user_id = curr_month.user_id
    AND EXTRACT(MONTH FROM last_month.event_date) =
    EXTRACT(MONTH FROM curr_month.event_date - interval '1 month')
)
  AND EXTRACT(MONTH FROM curr_month.event_date) = 7
  AND EXTRACT(YEAR FROM curr_month.event_date) = 2022
GROUP BY EXTRACT(MONTH FROM curr_month.event_date);