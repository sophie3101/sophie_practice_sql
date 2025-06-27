-- Objective:
-- Given a table of Twitter tweet data, write a query to get a histogram of tweets posted per user in 2022.
-- Each row in the result should show:
--   - tweet_bucket: the number of tweets posted by a user (e.g., 1, 2, 3, ...)
--   - users_num: the number of users who posted that number of tweets

-- Table: tweets
-- Columns:
--   tweet_id     INTEGER
--   user_id      INTEGER
--   msg          STRING
--   tweet_date   TIMESTAMP


SELECT tweet_bucket, COUNT(user_id) AS users_num
FROM 
  (SELECT user_id, COUNT(user_id) AS tweet_bucket
  FROM tweets
  WHERE EXTRACT(YEAR FROM tweet_date)='2022'
  GROUP BY user_id
  ) AS temp
GROUP BY tweet_bucket