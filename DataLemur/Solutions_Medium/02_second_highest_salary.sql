--Method 1
WITH temp AS (
  SELECT *,
  RANK() OVER(ORDER BY salary DESC) as salary_rank
  FROM employee
) 

SELECT salary FROM temp WHERE salary_rank=2 LIMIT 1

--Method 2
WITH temp AS (
  SELECT *,
  RANK() OVER(ORDER BY salary DESC) as salary_rank
  FROM employee
) 

SELECT salary FROM temp WHERE salary_rank=2 LIMIT 1