--My solution
WITH cte AS 
(
  SELECT user_id, amount, 
  TO_CHAR(transaction_date,'MM/DD/YYYY') AS date,
  EXTRACT(DAY FROM 
    LEAD(DATE_TRUNC('day', transaction_date) ) OVER(PARTITION BY user_id ORDER BY transaction_date)-
    DATE_TRUNC('day', transaction_date)) AS day_diff
  FROM transactions
)

SELECT user_id
FROM cte 
GROUP BY user_id 
HAVING count(user_id) >=3 AND SUM(day_diff)=2
