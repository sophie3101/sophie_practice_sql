
Identify returning active users by finding users who made a second purchase within 1 to 7 days after their first purchase. Ignore same-day purchases. Output a list of these user_ids.

```
WITH cte AS
(select user_id, created_at,
RANK()OVER(PARTITION BY user_id ORDER BY created_at),
LEAD(created_at) OVER(PARTITION BY user_id ORDER BY created_at) AS second_purchase_date
from amazon_transactions)

SELECT distinct user_id
FROM cte
WHERE rank=1 AND second_purchase_date - created_at BETWEEN 1 AND 7
```

SOLUTION 2
WITH first_purchase AS
  (SELECT user_id,
          MIN(created_at::date) AS first_purchase_date
   FROM amazon_transactions
   GROUP BY user_id)
SELECT DISTINCT a.user_id
FROM amazon_transactions b
JOIN first_purchase a ON a.user_id = b.user_id
WHERE b.created_at::date > a.first_purchase_date
  AND b.created_at::date <= a.first_purchase_date + INTERVAL '7 day'
ORDER BY a.user_id;