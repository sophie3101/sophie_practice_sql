SQL statement that determines the most and least experienced Spaceman ID by their job
description.

| Spaceman ID | Job Description | Mission Count |
| ----------- | --------------- | ------------- |
| 1001        | Astrogator      | 6             |
| 2002        | Astrogator      | 12            |
| 3003        | Astrogator      | 17            |
| 4004        | Geologist       | 21            |
| 5005        | Geologist       | 9             |

EXPECTED
| Job Description | Most Experienced | Least Experienced |
| --------------- | ---------------- | ----------------- |
| Astrogator | 3003 | 1001 |
| Geologist | 4004 | 6006 |
| Technician | 7007 | 8008 |

SCHEMA

```DROP TABLE IF EXISTS Personal;
CREATE TEMP TABLE Personal
(
SpacemanID      INTEGER PRIMARY KEY,
JobDescription  VARCHAR(100) NOT NULL,
MissionCount    INTEGER NOT NULL
);


INSERT INTO Personal (SpacemanID, JobDescription, MissionCount) VALUES
(1001,'Astrogator',6),(2002,'Astrogator',12),(3003,'Astrogator',17),
(4004,'Geologist',21),(5005,'Geologist',9),(6006,'Geologist',8),
(7007,'Technician',13),(8008,'Technician',2),(9009,'Technician',7);


```

SOLUTION

```
WITH cte AS (
	SELECT *,
	MAX(MissionCount)OVER(PARTITION BY JobDescription) as max_count,
	MIN(MissionCount)OVER(PARTITION BY JobDescription) as min_count
	FROM Personal
)

SELECT JobDescription,
MAX(CASE WHEN MissionCount=max_count THEN SpacemanID END) AS most_experienced,
MIN(CASE WHEN MissionCount=min_count THEN SpacemanID END) AS least_experienced
FROM cte
GROUP BY JobDescription


--other solution
WITH cte_MinMax AS
(
SELECT  JobDescription,
        MAX(MissionCount) AS MaxMissionCount,
        MIN(MissionCount) AS MinMissionCount
FROM    Personal
GROUP BY JobDescription
)

SELECT  a.JobDescription,
        b.SpacemanID AS MostExperienced,
        c.SpacemanID AS LeastExperienced
FROM    cte_MinMax a INNER JOIN
        Personal b ON a.JobDescription = b.JobDescription AND
                       a.MaxMissionCount = b.MissionCount  INNER JOIN
        Personal c ON a.JobDescription = c.JobDescription AND
                       a.MinMissionCount = c.MissionCount;
```
