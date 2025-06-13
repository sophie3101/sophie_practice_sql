SELECT mth, product_id, ROUND(AVG(stars),2)
FROM (
SELECT product_id, stars, EXTRACT(MONTH FROM submit_date) AS mth
FROM reviews ) AS temp 
GROUP BY temp.mth, temp.product_id
ORDER BY mth, product_id