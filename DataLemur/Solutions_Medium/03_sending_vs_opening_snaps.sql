-- Problem:
-- Snapchat wants to analyze how users across different age groups are spending their time on the app.
-- Specifically, we are interested in comparing the time spent on sending snaps versus opening snaps.

-- Task:
-- Write a SQL query to compute, for each age group, the percentage of time spent sending snaps
-- and the percentage of time spent opening snaps, relative to the combined time spent on these two activities.
-- Round both percentages to 2 decimal places.

-- Notes:
-- - Only consider 'send' and 'open' activity types; ignore others like 'chat'.
-- - Use the formula: 
--     send_perc = 100.0 * time_send / (time_send + time_open)
--     open_perc = 100.0 * time_open / (time_send + time_open)
-- - Use 100.0 (not 100) to ensure floating-point division.

-- Tables:
-- 1. activities
--    | Column Name     | Type     | Description                                   |
--    |------------------|----------|-----------------------------------------------|
--    | activity_id      | integer  | Unique ID of the activity                     |
--    | user_id          | integer  | ID of the user who performed the activity     |
--    | activity_type    | string   | Type of activity ('send', 'open', 'chat')     |
--    | time_spent       | float    | Time spent (in minutes) on the activity       |
--    | activity_date    | datetime | Date of the activity                          |

-- 2. age_breakdown
--    | Column Name  | Type     | Description                          |
--    |--------------|----------|--------------------------------------|
--    | user_id      | integer  | ID of the user                       |
--    | age_bucket   | string   | Age group of the user (e.g., '21-25')|

-- Example Output:
-- | age_bucket | send_perc | open_perc |
-- |------------|-----------|-----------|
-- | 26-30      | 65.40     | 34.60     |
-- | 31-35      | 43.75     | 56.25     |

SELECT age_bucket,
ROUND(100.0* SUM(time_spent) FILTER( WHERE activity_type='send')/SUM(time_spent), 2) AS send_perc,
ROUND(100.0* SUM(time_spent) FILTER( WHERE activity_type='open')/SUM(time_spent), 2) AS open_perc
FROM activities a 
JOIN age_breakdown b ON a.user_id = b.user_id 
WHERE activity_type in ('send', 'open')
GROUP BY age_bucket
ORDER BY age_bucket