SELECT user_id, spend, transaction_date
FROM (
  SELECT user_id, spend, transaction_date,
  RANK() OVER (PARTITION BY user_id ORDER BY transaction_date) AS rank
  FROM transactions
) AS temp
WHERE rank=3