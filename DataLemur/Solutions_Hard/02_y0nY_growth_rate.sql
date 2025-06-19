-- my method 
WITH cte AS (SELECT EXTRACT(YEAR FROM transaction_date) as year, product_id, SUM(spend)  AS spend
FROM user_transactions
GROUP BY EXTRACT(YEAR FROM transaction_date), product_id)

SELECT cur_year_cte.year, cur_year_cte.product_id, cur_year_cte.spend AS curr_year_spend,
        prev_year_cte.spend AS prev_year_spend,
        ROUND(100.0*(cur_year_cte.spend-prev_year_cte.spend)/prev_year_cte.spend , 2)
FROM cte  AS  cur_year_cte
LEFT JOIN cte AS prev_year_cte ON prev_year_cte.product_id = cur_year_cte.product_id 
  AND cur_year_cte.year - 1 = prev_year_cte.year
ORDER BY cur_year_cte.product_id, cur_year_cte.year 

--datalemur method
WITH yearly_spend_cte AS (
  SELECT 
    EXTRACT(YEAR FROM transaction_date) AS year,
    product_id,
    spend AS curr_year_spend,
    LAG(spend) OVER (
      PARTITION BY product_id 
      ORDER BY 
        product_id, 
        EXTRACT(YEAR FROM transaction_date)) AS prev_year_spend 
  FROM user_transactions
)

SELECT 
  year,
  product_id, 
  curr_year_spend, 
  prev_year_spend, 
  ROUND(100 * 
    (curr_year_spend - prev_year_spend)
    / prev_year_spend
  , 2) AS yoy_rate 
FROM yearly_spend_cte;