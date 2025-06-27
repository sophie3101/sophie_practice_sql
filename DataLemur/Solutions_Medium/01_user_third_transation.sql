-- Problem:
-- You are given a table of Uber transactions made by users.

-- Task:
-- Write a query to return the third transaction for **each user** based on the transaction date.
-- The result should include:
--   - user_id
--   - spend
--   - transaction_date
-- Only include users who have **at least three transactions**.
-- Assume `transaction_date` can be used to determine transaction order.

-- Table: transactions

-- Schema:
-- | Column Name       | Type      | Description                        |
-- |-------------------|-----------|------------------------------------|
-- | user_id           | integer   | Unique identifier for the user     |
-- | spend             | decimal   | Amount spent in the transaction    |
-- | transaction_date  | timestamp | Date and time of the transaction   |

-- Example Input:
-- | user_id | spend | transaction_date       |
-- |---------|--------|------------------------|
-- | 111     | 100.50 | 2022-01-08 12:00:00    |
-- | 111     | 55.00  | 2022-01-10 12:00:00    |
-- | 121     | 36.00  | 2022-01-18 12:00:00    |
-- | 145     | 24.99  | 2022-01-26 12:00:00    |
-- | 111     | 89.60  | 2022-02-05 12:00:00    |

-- Example Output:
-- | user_id | spend | transaction_date       |
-- |---------|--------|------------------------|
-- | 111

SELECT user_id, spend, transaction_date
FROM (
  SELECT user_id, spend, transaction_date,
  RANK() OVER (PARTITION BY user_id ORDER BY transaction_date) AS rank
  FROM transactions
) AS temp
WHERE rank=3