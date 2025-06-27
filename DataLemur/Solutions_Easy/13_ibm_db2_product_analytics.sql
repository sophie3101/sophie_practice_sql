-- Problem:
-- BM is analyzing how their employees are utilizing the Db2 database by tracking the SQL queries executed.
-- The goal is to generate a histogram showing the number of unique queries run by employees during 
-- Q3 of 2023 (July to September), and also to count employees who ran zero queries during this period.

-- Requirements:
-- - Count the number of unique queries each employee executed between July 1 and September 30, 2023.
-- - Display a histogram: for each count of unique queries, how many employees fall into that bucket.
-- - Include employees who ran 0 queries during the period.

-- Tables:

-- queries Table
-- | Column Name     | Type     | Description                                |
-- |------------------|----------|--------------------------------------------|
-- | employee_id      | integer  | The ID of the employee who executed the query. |
-- | query_id         | integer  | The unique identifier for each query (Primary Key). |
-- | query_starttime  | datetime | The timestamp when the query started.      |
-- | execution_time   | integer  | The duration of the query execution in seconds. |

-- Example queries Input (from July 2023):
-- | employee_id | query_id | query_starttime       | execution_time |
-- |-------------|----------|------------------------|----------------|
-- | 226         | 856987   | 07/01/2023 01:04:43    | 2698           |
-- | 132         | 286115   | 07/01/2023 03:25:12    | 2705           |
-- | 221         | 33683    | 07/01/2023 04:34:38    | 91             |
-- | 240         | 17745    | 07/01/2023 14:33:47    | 2093           |
-- | 110         | 413477   | 07/02/2023 10:55:14    | 470            |

-- employees Table
-- | Column Name  | Type     | Description                           |
-- |--------------|----------|---------------------------------------|
-- | employee_id  | integer  | The ID of the employee.               |
-- | full_name    | string   | The full name of the employee.        |
-- | gender       | string   | The gender of the employee.           |

-- Example employees Input:
-- | employee_id | full_name         | gender |
-- |-------------|-------------------|--------|
-- | 1           | Judas Beardon     | Male   |
-- | 2           | Lainey Franciotti | Female |
-- | 3           | Ashbey Strahan    | Male   |

-- Example Output:
-- | unique_queries | employee_count |
-- |----------------|----------------|
-- | 0              | 191            |
-- | 1              | 46             |
-- | 2              | 12             |
-- | 3              | 1              |

SELECT unique_queries, COUNT(*) AS employee_count
FROM (SELECT employees.employee_id, 
      SUM( CASE WHEN query_id IS NULL THEN 0 ELSE 1 END ) AS unique_queries
FROM queries 
RIGHT JOIN employees ON employees.employee_id = queries.employee_id 
        AND EXTRACT(MONTH FROM query_starttime) BETWEEN 7 AND 9
GROUP BY employees.employee_id) AS TEMP
GROUP BY unique_queries
ORDER BY unique_queries


--OTher solution
WITH employee_queries AS (
  SELECT 
    e.employee_id,
    COALESCE(COUNT(DISTINCT q.query_id), 0) AS unique_queries
  FROM employees AS e
  LEFT JOIN queries AS q
    ON e.employee_id = q.employee_id
      AND q.query_starttime >= '2023-07-01T00:00:00Z'
      AND q.query_starttime < '2023-10-01T00:00:00Z'
  GROUP BY e.employee_id
)

SELECT
  unique_queries,
  COUNT(employee_id) AS employee_count
FROM employee_queries
GROUP BY unique_queries
ORDER BY unique_queries;