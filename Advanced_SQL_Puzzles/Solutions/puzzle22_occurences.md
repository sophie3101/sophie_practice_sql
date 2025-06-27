Write an SQL statement that returns all distinct process log messages and the workflow where the
message occurred the most often

| Workflow | Message                            | Occurrences |
| -------- | ---------------------------------- | ----------- |
| Bravo    | Error: Cannot Divide by 0          | 3           |
| Alpha    | Error: Conversion Failed           | 5           |
| Charlie  | Error: Conversion Failed           | 7           |
| Alpha    | Error: Unidentified error occurred | 9           |
| Bravo    | Error: Unidentified error occurred | 1           |
| Charlie  | Error: Unidentified error occurred | 10          |
| Alpha    | Status Complete                    | 8           |
| Charlie  | Status Complete                    | 6           |

EXPECTED
| Workflow | Message | Occurrences |
|----------|--------------------------------------|-------------|
| Bravo | Error: Cannot Divide by 0 | 3 |
| Charlie | Error: Conversion Failed | 7 |
| Charlie | Error: Unidentified error occurred | 10 |
| Alpha | Status Complete | 8 |

```
DROP TABLE IF EXISTS ProcessLog;
CREATE TEMP TABLE ProcessLog
(
Workflow     VARCHAR(100),
LogMessage   VARCHAR(100),
Occurrences  INTEGER NOT NULL,
PRIMARY KEY (Workflow, LogMessage)
);


INSERT INTO ProcessLog (Workflow, LogMessage, Occurrences) VALUES
('Alpha','Error: Conversion Failed',5),
('Alpha','Status Complete',8),
('Alpha','Error: Unidentified error occurred',9),
('Bravo','Error: Cannot Divide by 0',3),
('Bravo','Error: Unidentified error occurred',1),
('Charlie','Error: Unidentified error occurred',10),
('Charlie','Error: Conversion Failed',7),
('Charlie','Status Complete',6);
```

SOLUTION

```
--solution 1
SELECT *
FROM (
SELECT *,
MAX(Occurrences) OVER(PARTITION BY LogMessage) as max_num
FROM ProcessLog p1 )
WHERE max_num = Occurrences

--Solution 2
SELECT *
FROM ProcessLog p1
WHERE Occurrences = (
    SELECT MAX(p2.Occurrences)
    FROM ProcessLog p2
    WHERE p2.LogMessage = p1.LogMessage
);
```
