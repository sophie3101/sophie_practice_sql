SELECT transaction_date, user_id,COUNT(product_id)
FROM 
(
  SELECT *, 
  RANK() OVER(PARTITION BY user_ID ORDER BY transaction_date DESC)
  FROM user_transactions
) AS temp
WHERE rank=1
GROUP BY  transaction_date, user_id