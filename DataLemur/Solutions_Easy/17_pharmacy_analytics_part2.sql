-- Problem:
-- CVS Health is analyzing its pharmacy sales to understand which products resulted in financial losses.
-- Each drug is manufactured by only one manufacturer.

-- Task:
-- Identify all manufacturers whose drugs caused losses for CVS Health.
-- A loss occurs when the cost of goods sold (COGS) is greater than the total sales.
-- For each manufacturer:
--   - Count the number of drugs that resulted in a loss
--   - Sum the total losses incurred (as an absolute value)
-- Sort the output in descending order by total loss, so the manufacturer with the highest loss appears first.

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
-- | product_id | units_sold | total_sales | cogs       | manufacturer | drug                         |
-- |------------|------------|-------------|------------|--------------|------------------------------|
-- | 156        | 89514      | 3130097.00  | 3427421.73 | Biogen       | Acyclovir                    |
-- | 25         | 222331     | 2753546.00  | 2974975.36 | AbbVie       | Lamivudine and Zidovudine    |
-- | 50         | 90484      | 2521023.73  | 2742445.90 | Eli Lilly    | D

SELECT
  manufacturer,
  COUNT(drug) AS drug_count, 
  SUM(cogs - total_sales) AS total_loss
FROM pharmacy_sales
WHERE cogs > total_sales
GROUP BY manufacturer
ORDER BY total_loss DESC;