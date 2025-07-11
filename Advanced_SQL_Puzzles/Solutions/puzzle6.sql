DROP TABLE IF EXISTS WorkflowSteps;


CREATE TEMP TABLE WorkflowSteps
(
Workflow        VARCHAR(100),
StepNumber      INTEGER,
CompletionDate  DATE NULL,
PRIMARY KEY (Workflow, StepNumber)
);


INSERT INTO WorkflowSteps (Workflow, StepNumber, CompletionDate) VALUES
('Alpha',1,'7/2/2018'),('Alpha',2,'7/2/2018'),('Alpha',3,'7/1/2018'),
('Bravo',1,'6/25/2018'),('Bravo',2,NULL),('Bravo',3,'6/27/2018'),
('Charlie',1,NULL),('Charlie',2,'7/1/2018');

--Solution
SELECT workflow
FROM WorkflowSteps
GROUP BY workflow
HAVING  COUNT(*) <> COUNT(CompletionDate)