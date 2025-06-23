DROP TABLE IF EXISTS WorkflowCases;


CREATE TEMP TABLE WorkflowCases
(
Workflow  VARCHAR(100) PRIMARY KEY,
Case1     INTEGER NOT NULL DEFAULT 0,
Case2     INTEGER NOT NULL DEFAULT 0,
Case3     INTEGER NOT NULL DEFAULT 0
);


INSERT INTO WorkflowCases (Workflow, Case1, Case2, Case3) VALUES
('Alpha',0,0,0),('Bravo',0,1,1),('Charlie',1,0,0),('Delta',0,0,0);

--Solution 1
WITH cte AS (SELECT workflow, 
CASE 
WHEN case1=1 THEN 1
ELSE 0 
END AS col
FROM WorkflowCases
UNION ALL
SELECT workflow, 
CASE 
WHEN case2=1 THEN 1 
ELSE 0
END AS col
FROM WorkflowCases
UNION ALL
SELECT workflow, 
CASE 
WHEN case3=1 THEN 1
ELSE 0
END AS col
FROM WorkflowCases
)
SELECT workflow, 
SUM(col) AS passed
FROM cte
GROUP BY workflow

--Solution 2
SELECT  Workflow,
        Case1 + Case2 + Case3 AS PassFail
FROM    WorkflowCases;