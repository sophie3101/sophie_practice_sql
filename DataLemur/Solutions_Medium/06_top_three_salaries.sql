-- Problem:
-- Identify the top 3 highest-earning employees in each department, including ties.
-- A 'high earner' is any employee with a salary rank of 3 or better within their department.
-- Use a window function (e.g., DENSE_RANK or RANK) to rank employees by salary within each department.
-- Join the employee table with the department table to get the department name.
-- Output columns: department_name, employee name, salary.
-- Sort results first by department_name ascending,
-- then by salary descending (highest salary first),
-- and finally by employee name alphabetically in case of salary ties.
-- The ranking function should handle duplicate salaries properly (include ties).
-- Only employees with rank <= 3 per department should be returned.

-- Tables:
-- employee(employee_id, name, salary, department_id, manager_id)
-- department(department_id, department_name)

-- Example output columns:
-- department_name | name           | salary
-- ------------------------------------------
-- Data Analytics  | James Anderson | 4000
-- Data Analytics  | Emma Thompson  | 3800
-- Data Analytics  | Daniel Rodriguez | 2230
-- Data Science    | Noah Johnson   | 6800
-- Data Science    | William Davis  | 6800

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