-- Problem:
-- Your team at JPMorgan Chase is preparing to launch a new credit card.
-- To gain insights, you're analyzing how many credit cards were issued each month.

-- Task:
-- Write a query that outputs:
--   - The name of each credit card
--   - The difference in the number of issued cards between the month with the highest issuance 
--     and the month with the lowest issuance (within the same year).
-- Sort the results by the largest difference in descending order.

-- Table: monthly_cards_issued

-- Schema:
-- | Column Name   | Type     |
-- |---------------|----------|
-- | card_name     | string   |
-- | issued_amount | integer  |
-- | issue_month   | integer  |
-- | issue_year    | integer  |

-- Example Input:
-- | card_name              | issued_amount | issue_month | issue_year |
-- |------------------------|---------------|-------------|------------|
-- | Chase Freedom Flex     | 55000         | 1           | 2021       |
-- | Chase Freedom Flex     | 60000         | 2           | 2021       |
-- | Chase Freedom Flex     | 65000         | 3           | 2021       |
-- | Chase Freedom Flex     | 70000         | 4           | 2021       |
-- | Chase Sapphire Reserve | 170000        | 1           | 2021       |
-- | Chase Sapphire Reserve | 175000        | 2           | 2021       |
-- | Chase Sapphire Reserve | 180000        | 3           | 2021       |

-- Example Output:
-- | card_name              | difference |
-- |------------------------|------------|
-- | Chase Freedom Flex     | 15000      |
-- | Chase Sapphire Reserve | 10000      |

-- Notes:
-- - Chase Freedom Flex: highest = 70,000, lowest = 55,000 → difference = 15,000
-- - Chase Sapphire Reserve: highest = 180,000, lowest = 170,000 → difference = 10,000

  SELECT distinct card_name, max_amount - min_amount
FROM (
SELECT card_name,
MAX(issued_amount) OVER (PARTITION BY card_name ) AS max_amount, 
MIN(issued_amount) OVER (PARTITION BY card_name ) AS min_amount
FROM monthly_cards_issued
) AS temp


--another way
SELECT card_name,
MAX(issued_amount) - MIN(issued_amount) AS diff
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY diff DESC