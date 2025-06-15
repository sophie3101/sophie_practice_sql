SELECT customer_id
FROM customer_contracts 
JOIN products ON products.product_id = customer_contracts.product_id
GROUP BY customer_id
HAVING COUNT(DISTINCT products.product_category) = (SELECT COUNT(DISTINCT products.product_category) FROM products)
