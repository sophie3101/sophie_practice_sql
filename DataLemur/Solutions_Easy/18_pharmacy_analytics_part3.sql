SELECT manufacturer, CONCAT('$', ROUND(sales/1000000), ' million') AS sale
FROM 
(SELECT manufacturer, SUM(total_sales) as sales 
  FROM pharmacy_sales
  GROUP BY manufacturer
) AS temp
ORDER BY  sales DESC, manufacturer