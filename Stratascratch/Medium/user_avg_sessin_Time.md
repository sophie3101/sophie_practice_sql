Calculate each user's average session time, where a session is defined as the time difference between a page_load and a page_exit. Assume each user has only one session per day. If there are multiple page_load or page_exit events on the same day, use only the latest page_load and the earliest page_exit, ensuring the page_load occurs before the page_exit. Output the user_id and their average session time.
```
WITH cte AS(
select user_id, TO_CHAR(timestamp, 'YYYY-MM-DD') as date,
MAX(timestamp) FILTER(WHERE action='page_load') as page_load,
MIN(timestamp) FILTER(WHERE action='page_exit') as page_exit
from facebook_web_log 
GROUP BY user_id, TO_CHAR(timestamp, 'YYYY-MM-DD')
)

SELECT user_id,AVG(page_exit - page_load) as avg_session
FROM cte
GROUP BY user_id
HAVING AVG(page_load - page_exit) IS NOT NULL
```