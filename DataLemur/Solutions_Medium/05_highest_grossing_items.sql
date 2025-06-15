
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