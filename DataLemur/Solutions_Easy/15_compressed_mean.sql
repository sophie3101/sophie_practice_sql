-- Problem:
-- You're trying to find the mean number of items per order on Alibaba, rounded to 1 decimal place.
-- You are given a table that includes:
--   - The count of items in each order (`item_count`)
--   - The number of orders for each item count (`order_occurrences`)

-- Table: items_per_order

-- Schema:
-- | Column Name        | Type     |
-- |--------------------|----------|
-- | item_count         | integer  | -- Number of items in an order
-- | order_occurrences  | integer  | -- Number of orders that had that item count

-- Example Input:
-- | item_count | order_occurrences |
-- |------------|-------------------|
-- | 1          | 500               |
-- | 2          | 1000              |
-- | 3          | 800               |
-- | 4          | 1000              |

-- Explanation:
-- - There are 500 orders with 1 item each, 1000 orders with 2 items, etc.
-- - Total items = (1*500) + (2*1000) + (3*800) + (4*1000) = 8900
-- - Total orders = 500 + 1000 + 800 + 1000 = 3300
-- - Mean = 8900 / 3300 = 2.7 (rounded to 1 decimal place)

-- Example Output:
-- | mean |
-- |------|
-- | 2.7  |

SELECT ROUND(CAST(SUM(order_occurrences * item_count) /SUM(order_occurrences) AS DECIMAL),1)
FROM items_per_order;