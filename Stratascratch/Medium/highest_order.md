Find the customers with the highest daily total order cost between 2019-02-01 and 2019-05-01. If a customer had more than one order on a certain day, sum the order costs on a daily basis. Output each customer's first name, total cost of their items, and the date.

`customers` table:
address:
text
city:
text
first_name:
text
id:
bigint
last_name:
text
phone_number:
text


```
-- get the daily sum orders
WITH filter_order_cte AS (
SELECT o.cust_id, o.order_date, SUM(total_order_cost) AS total_order_cost,
RANK()OVER( ORDER BY SUM(total_order_cost) desc)
FROM orders o
WHERE o.order_date BETWEEN '2019-02-01' AND '2019-05-01'
GROUP BY o.cust_id, o.order_date 
ORDER BY order_date
)

SELECT c.first_name, o.total_order_cost, o.order_date
FROM filter_order_cte o
JOIN customers c ON c.id = o.cust_id
WHERE rank=1
```