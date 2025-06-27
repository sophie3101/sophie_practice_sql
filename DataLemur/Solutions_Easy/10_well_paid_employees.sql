- Companies often perform salary analyses to ensure fair compensation practices.
-- One useful analysis is to check if there are any employees earning more than their direct managers.
-- 
-- As an HR Analyst, you're asked to identify all employees who earn more than their direct managers.
-- The result should include the employee's ID and name.

-- Table: employee

-- Schema:
-- | column_name   | type     | description                          |
-- |---------------|----------|--------------------------------------|
-- | employee_id   | integer  | The unique ID of the employee.       |
-- | name          | string   | The name of the employee.            |
-- | salary        | integer  | The salary of the employee.          |
-- | department_id | integer  | The department ID of the employee.   |
-- | manager_id    | integer  | The manager ID of the employee.      |

-- Example Input:
-- | employee_id | name             | salary | department_id | manager_id |
-- |-------------|------------------|--------|---------------|------------|
-- | 1           | Emma Thompson    | 3800   | 1             | 6          |
-- | 2           | Daniel Rodriguez | 2230   | 1             | 7          |
-- | 3           | Olivia Smith     | 7000   | 1             | 8          |
-- | 4           | Noah Johnson     | 6800   | 2             | 9          |
-- | 5           | Sophia Martinez  | 1750   | 1             | 11         |
-- | 6           | Liam Brown       | 13000  | 3             | NULL       |
-- | 7           | Ava Garcia       | 12500  | 3             | NULL       |
-- | 8           | William Davis    | 6800   | 2             | NULL       |

-- Example Output:
-- | employee_id | employee_name |
-- |-------------|----------------|
-- | 3           | Olivia Smith   |

SELECT e.employee_id, e.name 
FROM employee AS e
JOIN employee AS e2 ON e.manager_id = e2.employee_id
WHERE e2.salary < e.salary

