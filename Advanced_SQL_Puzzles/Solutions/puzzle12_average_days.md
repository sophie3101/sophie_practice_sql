Write an SQL statement to determine the average number of days between executions for each
workflow.
| Workflow | Execution Date |
|----------|----------------|
| Alpha | 6/1/2018 |
| Alpha | 6/14/2018 |
| Alpha | 6/15/2018 |
| Bravo | 6/1/2018 |
| Bravo | 6/2/2018 |
| Bravo | 6/19/2018 |
| Charlie | 6/1/2018 |
| Charlie | 6/15/2018 |
| Charlie | 6/30/2018 |

Expected:
| Workflow | Average Days |
|----------|--------------|
| Alpha | 7 |
| Bravo | 9 |
| Charlie | 14 |

```DROP TABLE IF EXISTS ProcessLog;
CREATE TEMP TABLE ProcessLog
(
WorkFlow       VARCHAR(100),
ExecutionDate  DATE,
PRIMARY KEY (WorkFlow, ExecutionDate)
);


INSERT INTO ProcessLog (WorkFlow, ExecutionDate) VALUES
('Alpha','6/01/2018'),('Alpha','6/14/2018'),('Alpha','6/15/2018'),
('Bravo','6/1/2018'),('Bravo','6/2/2018'),('Bravo','6/19/2018'),
('Charlie','6/1/2018'),('Charlie','6/15/2018'),('Charlie','6/30/2018');
```

Solution:

```
SELECT workflow, FLOOR(AVG(day_diff)) AS average_day
FROM (
SELECT *,
LEAD(ExecutionDate) OVER(PARTITION BY WorkFlow ORDER BY ExecutionDate) - ExecutionDate AS day_diff
FROM ProcessLog) AS temp
GROUP BY workflow
```
