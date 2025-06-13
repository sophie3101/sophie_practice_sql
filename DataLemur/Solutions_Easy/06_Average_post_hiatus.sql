SELECT user_id, EXTRACT(day FROM (MAX(post_date) - MIN(post_date))) AS diff_day
FROM posts
WHERE EXTRACT(YEAR FROM post_date) = 2021
GROUP BY user_id
HAVING  EXTRACT(day FROM (MAX(post_date) - MIN(post_date))) >0