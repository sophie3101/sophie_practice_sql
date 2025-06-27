The answer to this problem is often referred to as a data smear or a flash fill.

| Row Number | Workflow | Status |
| ---------- | -------- | ------ |
| 1          | Alpha    | Pass   |
| 2          |          | Fail   |
| 3          |          | Fail   |
| 4          |          | Fail   |
| 5          | Bravo    | Pass   |
| 6          |          | Fail   |
| 7          |          | Fail   |
| 8          |          | Pass   |
| 9          |          | Pass   |
| 10         | Charlie  | Fail   |
| 11         |          | Fail   |
| 12         |          | Fail   |

EXPECTED

| Row Number | Workflow | Status |
| ---------- | -------- | ------ |
| 1          | Alpha    | Pass   |
| 2          | Alpha    | Fail   |
| 3          | Alpha    | Fail   |
| 4          | Alpha    | Fail   |
| 5          | Bravo    | Pass   |
| 6          | Bravo    | Fail   |
| 7          | Bravo    | Fail   |
| 8          | Bravo    | Pass   |
| 9          | Bravo    | Pass   |
| 10         | Charlie  | Fail   |
| 11         | Charlie  | Fail   |
| 12         | Charlie  | Fail   |

SCHEMA

```DROP TABLE IF EXISTS Gaps;
CREATE TEMP TABLE Gaps
(
RowNumber   INTEGER PRIMARY KEY,
TestCase    VARCHAR(100) NULL
);
INSERT INTO Gaps (RowNumber, TestCase) VALUES
(1,'Alpha'),(2,NULL),(3,NULL),(4,NULL),
(5,'Bravo'),(6,NULL),(7,'Charlie'),(8,NULL),(9,NULL);
```

SOLUTION

```
--generate the count of non-null  TestCase
WITH cte AS (
  SELECT *,
  COUNT(TestCase)OVER(Order By RowNumber) AS distinct_count
  FROM Gaps
)

SELECT rownumber,
MAX(testcase) OVER(PARTITION BY distinct_count)
FROM cte
```
