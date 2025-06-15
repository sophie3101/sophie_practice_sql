--My solution
WITH cte AS (SELECT *,
CASE 
  WHEN order_id%2=0 THEN LAG(item) OVER(ORDER BY order_id)
  WHEN order_id%2=1 THEN LEAD(item) OVER(ORDER BY order_id)
END AS modified_item
FROM orders 
)

SELECT order_id, 
  CASE 
    WHEN modified_item IS NULL THEN item 
    ELSE modified_item
  END 
FROM cte

--Other solution
WITH order_counts AS (
  SELECT COUNT(order_id) AS total_orders 
  FROM orders
)

SELECT
  CASE
    WHEN order_id % 2 != 0 AND order_id != total_orders THEN order_id + 1
    WHEN order_id % 2 != 0 AND order_id = total_orders THEN order_id
    ELSE order_id - 1
  END AS corrected_order_id,
  item
FROM orders
CROSS JOIN order_counts
ORDER BY corrected_order_id;