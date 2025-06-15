WITH temp AS (
  SELECT e.name, e.salary, d.department_name,
        DENSE_RANK() OVER(PARTITION BY d.department_name ORDER BY salary DESC) AS salary_rank
  FROM employee e 
  JOIN department d ON e.department_id = d.department_id
)

SELECT department_name , name, salary 
FROM temp 
WHERE salary_rank <=3
ORDER BY department_name, salary DESC, name