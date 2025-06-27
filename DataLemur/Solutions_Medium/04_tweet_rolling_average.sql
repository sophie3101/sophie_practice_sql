-- Problem:
-- Calculate the 3-day rolling average of tweet counts for each user.
-- The rolling average shows the average tweet count over the current day and the two preceding days.

-- Task:
-- For each user and each tweet date, compute the average tweet_count for the current day and previous two days.
-- Output columns: user_id, tweet_date, rolling_avg_3d (rounded to 2 decimal places).

-- Notes:
-- - Use a window function with a 3-day frame to calculate the rolling average.
-- - If there are fewer than 3 days of data available (e.g., the first or second day), calculate the average for the available days.
-- - Round the final average to 2 decimal places.
-- - tweet_date is assumed to be a timestamp, but the rolling average should consider daily aggregation.

-- Table:
-- tweets
-- | Column Name | Type      | Description             |
-- |-------------|-----------|-------------------------|
-- | user_id     | integer   | ID of the user          |
-- | tweet_date  | timestamp | Date of the tweet count |
-- | tweet_count | integer   | Number of tweets on date|

-- Example Output:
-- | user_id | tweet_date          | rolling_avg_3d |
-- |---------|---------------------|----------------|
-- | 111     | 2022-06-01 00:00:00 | 2.00           |
-- | 111     | 2022-06-02 00:00:00 | 1.50           |
-- | 111     | 2022-06-03 00:00:00 | 2.00           |
-- | 111     | 2022-06-04 00:00:00 | 2.67           |
-- | 111     | 2022-06-05 00:00:00 | 4.00           |

SELECT user_id, tweet_date,
ROUND (AVG(tweet_count) OVER(
 PARTITION BY user_id     
  ORDER BY tweet_date
  ROWS BETWEEN 2 PRECEDING AND CURRENT ROW ),2) AS rolling_avg_3d
FROM tweets;