/*
Problem Description:
Zomato experienced a delivery driver instruction error causing each ordered item's row to be swapped with the subsequent row.

Goal:
As a data analyst, fix the swapping error and return the corrected pairing of order IDs and items.

Rules:
- Items at odd order IDs are swapped with the subsequent even order ID's item.
- If the last order ID is odd, it should remain unchanged in the corrected data.
- Return corrected pairs of order IDs and items.

Input Schema:
Table: orders
Columns:
- order_id (integer): unique order ID
- item (string): name of the food item ordered

Example Input:
order_id | item
----------------------
1        | Chow Mein
2        | Pizza
3        | Pad Thai
4        | Butter Chicken
5        | Eggrolls
6        | Burger
7        | Tandoori Chicken

Example Output:
corrected_order_id | item
----------------------------
1                  | Pizza
2                  | Chow Mein
3                  | Butter Chicken
4                  | Pad Thai
5                  | Burger
6                  | Eggrolls
7                  | Tandoori Chicken

Explanation:
- Each pair of consecutive orders swap their items.
- Last order with an odd order_id remains unchanged if unpaired.
- The correction aligns orders with their true intended items.
*/

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