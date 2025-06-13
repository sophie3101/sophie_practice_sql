SELECT ROUND(CAST(SUM(order_occurrences * item_count) /SUM(order_occurrences) AS DECIMAL),1)
FROM items_per_order;