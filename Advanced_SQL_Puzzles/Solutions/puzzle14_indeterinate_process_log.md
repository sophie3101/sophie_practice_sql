Your process log has several workflows broken down by step numbers with the possible status values of
Complete, Running, or Error. \
Your task is to write an SQL statement that creates an overall status based on the following
requirements.\

- If all steps of a workflow are of the same status (Error, Complete, or Running), then return the
  distinct status.
- If any steps of a workflow have an Error status along with a status of Complete or Running, set
  the overall status to Indeterminate.
- If the workflow steps have a combination of Complete and Running (without any Errors), set the
  overall status to Running.
  | Workflow | Step Number | Status |
  |----------|-------------|----------|
  | Alpha | 1 | Error |
  | Alpha | 2 | Complete |
  | Alpha | 3 | Running |
  | Bravo | 1 | Complete |
  | Bravo | 2 | Complete |
  | Charlie | 1 | Running |
  | Charlie | 2 | Running |
  | Delta | 1 | Error |
  | Delta | 2 | Error |
  | Echo | 1 | Running |
  | Echo | 2 | Complete |

EXPECTED:
| Workflow | Status |
|----------|--------------|
| Alpha | Indeterminate|
| Bravo | Complete |
| Charlie | Running |
| Delta | Error |
| Echo | Running |

SCHEMA

```
DROP TABLE IF EXISTS ProcessLog;


CREATE TEMP TABLE ProcessLog
(
Workflow    VARCHAR(100),
StepNumber  INTEGER,
RunStatus   VARCHAR(100) NOT NULL,
PRIMARY KEY (Workflow, StepNumber)
);


INSERT INTO ProcessLog (Workflow, StepNumber, RunStatus) VALUES
('Alpha',1,'Error'),('Alpha',2,'Complete'),('Alpha',3,'Running'),
('Bravo',1,'Complete'),('Bravo',2,'Complete'),
('Charlie',1,'Running'),('Charlie',2,'Running'),
('Delta',1,'Error'),('Delta',2,'Error'),
('Echo',1,'Running'),('Echo',2,'Complete');

```

SOLUTION

```
WITH cte AS (
  SELECT
    workflow,
    CAST(STRING_AGG(distinct RunStatus, ',') AS VARCHAR(1000)) AS status
  FROM ProcessLog
  GROUP BY workflow
)
SELECT *,
CASE
	WHEN cardinality(string_to_array(status,',')) = 3 THEN 'Indeterminate'
	WHEN cardinality(string_to_array(status,',')) = 1 THEN status
	WHEN cardinality(string_to_array(status,',')) = 2 AND status NOT like  '%Error%' THEN 'Running'
	WHEN cardinality(string_to_array(status,',')) = 2 AND status like '%Error%' THEN 'Error'
END
FROM cte;

--solution 2
WITH cte AS (
  SELECT
    workflow,
    CAST(STRING_AGG(distinct RunStatus, ',') AS VARCHAR(1000)) AS status,
	COUNT(distinct RunStatus)
  FROM ProcessLog
  GROUP BY workflow
)

SELECT workflow,
CASE
WHEN count=1 THEN status
WHEN Status LIKE '%Error%' THEN 'Indeterminate'
WHEN Status LIKE '%Running%' THEN 'Running'
END

FROM cte;
```
