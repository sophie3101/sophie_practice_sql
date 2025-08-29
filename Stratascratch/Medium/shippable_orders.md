https://platform.stratascratch.com/coding/10090-find-the-percentage-of-shipable-orders?code_type=1
Find the percentage of shipable orders.
Consider an order is shipable if the customer's address is known.

```
WITH cte AS 
    (select id
    FROM orders 
    WHERE EXISTS(
    SELECT 1
    FROM customers 
    WHERE customers.id = orders.cust_id
    AND customers.address IS NOT NULL)
)
SELECT 100.0*COUNT(cte.id)/COUNT(orders.id) AS percent_shipable
FROM orders 
LEFT JOIN cte ON orders.id = cte.id

---better solution
SELECT
  100.0 * SUM(CASE WHEN NULLIF(TRIM(c.address), '') IS NOT NULL THEN 1 ELSE 0 END)
  / COUNT(DISTINCT o.id) AS percent_shipable
FROM orders o
LEFT JOIN customers c
  ON o.cust_id = c.id;

---
SELECT 100.0*COUNT(customers.address)/COUNT(orders.id)
FROM orders 
LEFT JOIN customers ON orders.cust_id = customers.id
```