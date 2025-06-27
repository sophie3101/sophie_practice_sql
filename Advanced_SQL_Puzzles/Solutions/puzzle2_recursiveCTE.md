Given the following hierarchical table, write an SQL statement that determines the level of depth each
employee has from the president.

| Employee ID | Manager ID | Job Title      |
| ----------- | ---------- | -------------- |
| 1001        |            | President      |
| 2002        | 1001       | Director       |
| 3003        | 1001       | Office Manager |
| 4004        | 2002       | Engineer       |
| 5005        | 2002       | Engineer       |
| 6006        | 2002       | Engineer       |

✅ Expected Output
| Employee ID | Manager ID | Job Title | Depth |
|-------------|------------|-----------------|--------|
| 1001 | | President | 0 |
| 2002 | 1001 | Director | 1 |
| 3003 | 1001 | Office Manager | 1 |
| 4004 | 2002 | Engineer | 2 |
| 5005 | 2002 | Engineer | 2 |
| 6006 | 2002 | Engineer | 2 |

SCHEMA

```
DROP TABLE IF EXISTS Employees;

CREATE TEMP TABLE Employees
(
EmployeeID  INTEGER PRIMARY KEY,
ManagerID   INTEGER NULL,
JobTitle    VARCHAR(100) NOT NULL
);


INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) VALUES
(1001,NULL,'President'),(2002,1001,'Director'),
(3003,1001,'Office Manager'),(4004,2002,'Engineer'),
(5005,2002,'Engineer'),(6006,2002,'Engineer');
```

SOLUTION

```
WITH RECURSIVE cte AS (
SELECT EmployeeID, ManagerID, JobTitle, 0 AS depth
FROM Employees
WHERE managerid IS NULL

UNION ALL
SELECT e.EmployeeID, e.ManagerID, e.JobTitle, cte.depth + 1
FROM Employees e
JOIN cte ON e.managerid=cte.employeeid
)

SELECT * FROM cte
```
