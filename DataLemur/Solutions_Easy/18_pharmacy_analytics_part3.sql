-- Problem:
-- CVS Health wants a clear summary of its pharmacy sales performance by manufacturer.

-- Task:
-- Calculate the total drug sales for each manufacturer using the `total_sales` column.
-- Round the total sales to the nearest **million**.
-- Format the output in the form: "$<amount> million", e.g., "$36 million".
-- Sort the results:
--   - First, by total sales in descending order.
--   - Then alphabetically by manufacturer name in case of ties.

-- This data is intended for a business stakeholder dashboard, so formatting and clarity are key.

-- Table: pharmacy_sales

-- Schema:
-- | Column Name   | Type     | Description                                      |
-- |---------------|----------|--------------------------------------------------|
-- | product_id    | integer  | Unique identifier for each product               |
-- | units_sold    | integer  | Number of units sold                             |
-- | total_sales   | decimal  | Total revenue from drug sales                    |
-- | cogs          | decimal  | Cost of goods sold                               |
-- | manufacturer  | varchar  | Drug manufacturer                                |
-- | drug          | varchar  | Drug name                                        |

-- Example Input:
-- | product_id | units_sold | total_sales | cogs       | manufacturer | drug             |
-- |------------|------------|-------------|------------|--------------|------------------|
-- | 94         | 132362     | 2041758.41  | 1373721.70 | Biogen       | UP and UP        |
-- | 9          | 37410      | 293452.54   | 208876.01  | Eli Lilly    | Zyprexa          |
-- | 50         | 90484      | 2521023.73  | 2742445.90 | Eli Lilly    | Dermasorb        |
-- | 61         | 77023      | 500101.61   | 419174.97  | Biogen       | Varicose Relief  |
-- | 136        | 144814     | 1084258.00  | 1006447.73 | Biogen       | Burkhart         |

-- Example Output:
-- | manufacturer | sale        |
-- |--------------|-------------|
-- | Biogen       | $4 million  |
-- | Eli Lilly    | $3 million  |

SELECT manufacturer, CONCAT('$', ROUND(sales/1000000), ' million') AS sale
FROM 
(SELECT manufacturer, SUM(total_sales) as sales 
  FROM pharmacy_sales
  GROUP BY manufacturer
) AS temp
ORDER BY  sales DESC, manufacturer