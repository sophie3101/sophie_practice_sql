-- Problem:
-- Identify the top two highest-grossing products in each category for the year 2022.
-- For each category, calculate the total spend per product from transactions made in 2022.
-- Output the category, product, and total spend.
-- Sort the results by category and total spend descending.
-- Only show the top two products per category.

-- Notes:
-- - Filter transactions to only include those in the year 2022.
-- - Use a window function (e.g., ROW_NUMBER or RANK) partitioned by category to rank products by total spend.
-- - Select only the top 2 products per category.
-- - The total spend is the sum of spend per product within the filtered period.

-- Table: product_spend
-- | Column Name      | Type      | Description                     |
-- |------------------|-----------|---------------------------------|
-- | category         | string    | Product category                |
-- | product          | string    | Product name                   |
-- | user_id          | integer   | ID of the user making purchase |
-- | spend            | decimal   | Amount spent on product         |
-- | transaction_date | timestamp | Date of transaction             |

-- Example Output:
-- | category    | product           | total_spend |
-- |-------------|-------------------|-------------|
-- | appliance   | refrigerator      | 299.99      |
-- | appliance   | washing machine   | 219.80      |
-- | electronics | vacuum            | 341.00      |
-- | electronics | wireless headset  | 249.90      |

WITH temp AS (SELECT category, product, 
        SUM(spend) as total_spend,
        RANK() OVER (PARTITION BY category ORDER BY SUM(spend) DESC)
FROM product_spend
WHERE EXTRACT(YEAR FROM transaction_date)='2022'
GROUP BY category, product
ORDER BY category, total_spend DESC)

SELECT category, product, total_spend
FROM temp 
WHERE rank<=2