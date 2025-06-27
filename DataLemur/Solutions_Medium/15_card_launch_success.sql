
-- Your team at JPMorgan Chase is preparing to launch a new credit card.
-- In order to estimate how many cards might be issued in the first month, 
-- you want to analyze the performance of previous credit card launches.

-- Objective:
-- Write a query to find out how many cards were issued in the **launch month** of each credit card.
-- The launch month is defined as the **earliest** (i.e. first) record for a given card in the monthly_cards_issued table.
-- Return two columns:
--   1. card_name
--   2. issued_amount (in the launch month)
-- Sort the results by issued_amount in **descending** order (from most to least issued).

-- Table: monthly_cards_issued
-- Column Name     Type
-- issue_month     integer       -- Month when cards were issued (1 = January, ..., 12 = December)
-- issue_year      integer       -- Year when cards were issued
-- card_name       string        -- Name of the credit card
-- issued_amount   integer       -- Number of cards issued in that month

-- Example Input:
-- issue_month   issue_year   card_name               issued_amount
-- 1             2021         Chase Sapphire Reserve  170000
-- 2             2021         Chase Sapphire Reserve  175000
-- 3             2021         Chase Sapphire Reserve  180000
-- 3             2021         Chase Freedom Flex      65000
-- 4             2021         Chase Freedom Flex      70000

-- Expected Output:
-- card_name               issued_amount
-- Chase Sapphire Reserve  170000
-- Chase Freedom Flex       65000

-- Explanation:
-- - Chase Sapphire Reserve launched in 1/2021 with 170,000 cards issued.
-- - Chase Freedom Flex launched in 3/2021 with 65,000 cards issued.
-- Results are sorted in descending order by issued_amount.

-- My method
SELECT card_name, issued_amount 
FROM (
  SELECT *,
    RANK() OVER(PARTITION BY card_name ORDER BY issue_year ASC, issue_month)
  FROM monthly_cards_issued
  ORDER BY card_name ,issue_year, issue_month) AS temp
WHERE rank=1
ORDER BY issued_amount DESC

--DataLemur solution
WITH card_launch AS (
  SELECT 
    card_name,
    issued_amount,
    MAKE_DATE(issue_year, issue_month, 1) AS issue_date,
    MIN(MAKE_DATE(issue_year, issue_month, 1)) OVER (
      PARTITION BY card_name) AS launch_date
  FROM monthly_cards_issued
)

SELECT 
  card_name, 
  issued_amount
FROM card_launch
WHERE issue_date = launch_date
ORDER BY issued_amount DESC;

/*

make_date ( year int, month int, day int ) → date

Create date from year, month and day fields (negative years signify BC)

make_date(2013, 7, 15) → 2013-07-15
*/