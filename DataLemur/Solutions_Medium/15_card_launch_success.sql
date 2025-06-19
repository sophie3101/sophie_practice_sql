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