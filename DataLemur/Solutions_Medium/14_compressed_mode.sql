/*
Task:
Identify the mode(s) of order occurrences from the `items_per_order` table.

Definitions:
- item_count: Number of items in an order.
- order_occurrences: Number of times that specific item_count occurred.

Goal:
- Find the item_count(s) that have the highest order_occurrences (i.e., the mode).
- If multiple item_counts share the same maximum order_occurrences, return all of them sorted in ascending order.

Example:
Given:
item_count | order_occurrences
-----------|------------------
1          | 500
2          | 1000
3          | 800

Output:
mode
----
2

Explanation:
Item count 2 has the highest order occurrence (1000), making it the mode.
*/

WITH max_freq AS (
  SELECT MAX(order_occurrences) AS max_occurrence
  FROM items_per_order
)
SELECT item_count AS mode
FROM items_per_order
WHERE order_occurrences = (SELECT max_occurrence FROM max_freq)
ORDER BY item_count;

SELECT item_count
FROM items_per_order
WHERE  order_occurrences = (
  SELECT MODE() WITHIN GROUP (ORDER BY order_occurrences DESC)
  FROM items_per_order
  )


--Other solution
SELECT item_count AS mode
FROM items_per_order
WHERE order_occurrences = (
  SELECT MAX(order_occurrences) 
  FROM items_per_order
)
ORDER BY item_count;