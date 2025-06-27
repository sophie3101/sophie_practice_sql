-- Problem:
-- CVS Health is analyzing pharmacy sales to identify which drugs are the most profitable.
-- Each drug is produced by only one manufacturer.

-- Task:
-- Write a query to return the top 3 most profitable drugs sold.
-- For each drug, calculate the total profit as:
--   Total Profit = Total Sales - Cost of Goods Sold (COGS)
-- Display the drug name and its total profit.
-- Sort the output from highest to lowest profit.
-- Assume there are no ties in profits.

-- Table: pharmacy_sales

-- Schema:
-- | Column Name   | Type     | Description                                      |
-- |---------------|----------|--------------------------------------------------|
-- | product_id    | integer  | Unique identifier for each product               |
-- | units_sold    | integer  | Number of units sold                             |
-- | total_sales   | decimal  | Total revenue from sales                         |
-- | cogs          | decimal  | Cost of goods sold                               |
-- | manufacturer  | varchar  | Drug manufacturer                                |
-- | drug          | varchar  | Name of the drug                                 |

-- Example Input:
-- | product_id | units_sold | total_sales | cogs       | manufacturer | drug             |
-- |------------|------------|-------------|------------|--------------|------------------|
-- | 9          | 37410      | 293452.54   | 208876.01  | Eli Lilly    | Zyprexa          |
-- | 34         | 94698      | 600997.19   | 521182.16  | AstraZeneca  | Surmontil        |
-- | 61         | 77023      | 500101.61   | 419174.97  | Biogen       | Varicose Relief  |
-- | 136        | 144814     | 1084258.00  | 1006447.73 | Biogen       | Burkhart         |

-- Example Output:
-- | drug             | total_profit |
-- |------------------|--------------|
-- | Zyprexa          | 84576.53     |
-- | Varicose Relief  | 80926.64     |
-- | Surmontil        | 79815.03     |
SELECT drug, 
  total_sales - cogs AS profit
FROM pharmacy_sales
ORDER BY profit DESC
LIMIT 3

--ORDER BY clause is processed after the SELECT clause