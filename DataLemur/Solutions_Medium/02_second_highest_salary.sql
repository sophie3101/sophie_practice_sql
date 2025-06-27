-- Problem:
-- As an HR analyst at a tech company, you are tasked with analyzing employee compensation.
-- Your manager wants insight into salary distribution by identifying the second highest salary.

-- Task:
-- Write a SQL query to find the **second highest distinct salary** among all employees.
-- If multiple employees share the second highest salary, output it **only once**.
-- Do not return any employee details — just the salary value.

-- Table: employee

-- Schema:
-- | column_name    | type     | description                             |
-- |----------------|----------|-----------------------------------------|
-- | employee_id    | integer  | The unique ID of the employee           |
-- | name           | string   | The name of the employee                |
-- | salary         | integer  | The salary of the employee              |
-- | department_id  | integer  | The department ID the employee belongs to|
-- | manager_id     | integer  | The manager ID for the employee         |

-- Example Input:
-- | employee_id | name              | salary | department_id | manager_id |
-- |-------------|-------------------|--------|----------------|------------|
-- | 1           | Emma Thompson     | 3800   | 1              | 6          |
-- | 2           | Daniel Rodriguez  | 2230   | 1              | 7          |
-- | 3           | Olivia Smith      | 2000   | 1              | 8          |

-- Example Output:
-- | second_highest_salary |
-- |------------------------|
-- | 2230                  |

-- Explanation:
-- The distinct salaries are [3800, 2230, 2000].
-- The second highest is 2230.
-- The result includes only the salary, not the employee name or ID.

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
--Method 3
SELECT MAX(salary)
FROM employee
WHERE salary < (SELECT MAX(salary) FROM employee)