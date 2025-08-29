https://platform.stratascratch.com/coding/9782-customer-revenue-in-march?code_type=1
Calculate the total revenue from each customer in March 2019. Include only customers who were active in March 2019. An active user is a customer who made at least one transaction in March 2019.


Output the revenue along with the customer id and sort the results based on the revenue in descending order.

```
select cust_id, SUM(total_order_cost)
from orders
WHERE DATE_TRUNC('month', order_date) = '2019-03-01'
GROUP BY cust_id
```