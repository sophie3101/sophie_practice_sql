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