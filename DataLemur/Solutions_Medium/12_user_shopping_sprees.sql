/*
Task:
Identify users who have gone on at least one "shopping spree" — defined as making purchases on 3 or more consecutive days.

Input:
- transactions table containing:
  - user_id (integer): unique identifier for each user
  - amount (float): purchase amount
  - transaction_date (timestamp): date and time of the transaction

Goal:
- List user IDs (ascending) of users who made purchases on 3 or more consecutive days.
- A "shopping spree" means at least 3 consecutive calendar days with transactions.

Example Input:
user_id | amount | transaction_date
1       | 9.99   | 08/01/2022 10:00:00
1       | 55     | 08/17/2022 10:00:00
2       | 149.5  | 08/05/2022 10:00:00
2       | 4.89   | 08/06/2022 10:00:00
2       | 34     | 08/07/2022 10:00:00

Example Output:
user_id
2

Explanation:
User 2 has transactions on 08/05, 08/06, and 08/07 — three consecutive days, qualifying as a shopping spree.
*/

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
