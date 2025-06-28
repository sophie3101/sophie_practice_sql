/*
Assume you're given a table containing information on Facebook user actions.
Write a query to obtain the number of monthly active users (MAUs) in July 2022,
including the month in numerical format (e.g., 1, 2, 3).

Hint:
An active user is defined as a user who has performed actions such as 'sign-in',
'like', or 'comment' in both the current month and the previous month.

Table: user_actions

Columns:
- user_id (integer)
- event_id (integer)
- event_type (string: "sign-in", "like", "comment")
- event_date (datetime)

Example Input:
user_id | event_id | event_type | event_date
--------|----------|------------|-----------------------
445     | 7765     | sign-in    | 2022-05-31 12:00:00
742     | 6458     | sign-in    | 2022-06-03 12:00:00
445     | 3634     | like       | 2022-06-05 12:00:00
742     | 1374     | comment    | 2022-06-05 12:00:00
648     | 3124     | like       | 2022-06-18 12:00:00

Example Output for June 2022:
month | monthly_active_users
------|----------------------
6     | 1

Explanation:
In June 2022, there was only one monthly active user (MAU), user_id 445, 
who was active in both May and June.

Note:
The output above is based on the provided data, which only includes up to June.
Your query should compute MAUs for July 2022 instead.
*/

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