/*
Task:
Retrieve Walmart users along with the count of products they purchased in their most recent transaction.

Input:
- user_transactions table with columns:
  - product_id (integer)
  - user_id (integer)
  - spend (decimal)
  - transaction_date (timestamp)

Goal:
- For each user, find their most recent transaction date.
- Count the number of products bought on that most recent transaction date.
- Output the transaction date, user ID, and purchase count.
- Sort results chronologically by transaction date.

Example Input:
product_id | user_id | spend  | transaction_date
3673       | 123     | 68.90  | 07/08/2022 12:00:00
9623       | 123     | 274.10 | 07/08/2022 12:00:00
1467       |
Example Output:
transaction_date	user_id	purchase_count
07/08/2022 12:00:00	115	1
07/08/2022 12:00:000	123	2
07/10/2022 12:00:00	159	1
*/
SELECT transaction_date, user_id,COUNT(product_id)
FROM 
(
  SELECT *, 
  RANK() OVER(PARTITION BY user_ID ORDER BY transaction_date DESC)
  FROM user_transactions
) AS temp
WHERE rank=1
GROUP BY  transaction_date, user_id