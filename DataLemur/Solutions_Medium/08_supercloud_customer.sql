-- Problem:
-- Identify customers who have purchased at least one product from every product category.
-- A customer qualifies as a Supercloud customer if their purchased products cover all categories.

-- Tables:
-- customer_contracts(customer_id, product_id, amount)
-- products(product_id, product_category, product_name)

-- Approach:
-- 1. Determine the distinct list of all product categories from the products table.
-- 2. For each customer, find the distinct product categories they have purchased.
-- 3. Compare the count of distinct categories purchased by each customer with the total number of categories.
-- 4. Return customer_ids whose count of purchased categories equals the total categories count.

-- Steps:
-- - Join customer_contracts and products on product_id.
-- - Group by customer_id and count distinct product categories.
-- - Use a HAVING clause to keep only customers with count = total number of distinct product categories.

SELECT customer_id
FROM customer_contracts 
JOIN products ON products.product_id = customer_contracts.product_id
GROUP BY customer_id
HAVING COUNT(DISTINCT products.product_category) = (SELECT COUNT(DISTINCT products.product_category) FROM products)
