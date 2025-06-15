SELECT drug, 
  total_sales - cogs AS profit
FROM pharmacy_sales
ORDER BY profit DESC
LIMIT 3

--ORDER BY clause is processed after the SELECT clause