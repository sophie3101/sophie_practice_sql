https://platform.stratascratch.com/coding/9897-highest-salary-in-department?code_type=1
Find the employee with the highest salary per department.
Output the department name, employee's first name along with the corresponding salary.
```
WITH cte AS (
select first_name, salary, department,
RANK()OVER(PARTITION BY department ORDER BY salary DESC) AS rnk
from employee
)

SELECT department, first_name, salary
FROM cte
WHERE rnk=1


--other solution
WITH salary_per_department AS
  (SELECT department,
          MAX(salary) AS max_salary
   FROM employee
   GROUP BY department)
SELECT e.department,
       e.first_name,
       e.salary
FROM employee e
JOIN salary_per_department s ON e.department = s.department
AND e.salary = s.max_salary
ORDER BY e.department;

```