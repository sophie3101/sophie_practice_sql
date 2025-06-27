-- For each user who posted at least twice in 2021,
-- calculate the number of days between their first and last post of the year.

-- Table: posts
-- Columns:
--   user_id      INTEGER
--   post_id      INTEGER
--   post_content TEXT
--   post_date    TIMESTAMP

SELECT user_id, EXTRACT(day FROM (MAX(post_date) - MIN(post_date))) AS diff_day
FROM posts
WHERE EXTRACT(YEAR FROM post_date) = 2021
GROUP BY user_id
HAVING  EXTRACT(day FROM (MAX(post_date) - MIN(post_date))) >0