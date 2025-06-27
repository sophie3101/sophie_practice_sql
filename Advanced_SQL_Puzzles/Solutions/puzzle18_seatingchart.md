Given the set of integers provided in the following DDL statement, write the SQL statements to
determine the following:

- Gap start and gap ends
- Total missing numbers
- Count of odd and even numbers

EXPECTED OUTPUT
| Gap Start | Gap End |
| --------- | ------- |
| 1 | 6 |
| 8 | 12 |
| 16 | 26 |
| 36 | 51 |

| Type         | Count |
| ------------ | ----- |
| Even Numbers | 7     |
| Odd Numbers  | 9     |

```
DROP TABLE IF EXISTS SeatingChart;
CREATE TEMP TABLE SeatingChart
(
SeatNumber  INTEGER PRIMARY KEY
);
INSERT INTO SeatingChart (SeatNumber) VALUES
(7),(13),(14),(15),(27),(28),(29),(30),(31),(32),(33),(34),(35),(52),(53),(54);
```

SOLUTION

```
WITH cte_Gaps AS
(
SELECT  SeatNumber AS GapStart,
        LEAD(SeatNumber,1,0) OVER (ORDER BY SeatNumber) AS GapEnd,
        LEAD(SeatNumber,1,0) OVER (ORDER BY SeatNumber) - SeatNumber AS Gap
FROM    SeatingChart
)

SELECT  GapStart + 1 AS GapStart,
        GapEnd - 1 AS GapEnd
FROM    cte_Gaps
WHERE Gap > 1;

--MIssing number
--soluton 1
SELECT MAX(SeatNumber) - COUNT(SeatNumber)
FROM SeatingChart
--solution2
WITH cte_Rank
AS
(
SELECT  SeatNumber,
        ROW_NUMBER() OVER (ORDER BY SeatNumber) AS RowNumber,
        SeatNumber - ROW_NUMBER() OVER (ORDER BY SeatNumber) AS Rnk
FROM    SeatingChart
WHERE   SeatNumber > 0
)
SELECT  MAX(Rnk) AS MissingNumbers
FROM    cte_Rank;

--Count of odd and even numbers
SELECT 'Even' AS Type, COUNT(*) FILTER(WHERE SeatNumber % 2 =0)
FROM SeatingChart
UNION
SELECT 'Odd' AS Type, COUNT(*) FILTER(WHERE SeatNumber % 2 =1)
FROM SeatingChart

--other solution
SELECT
	CASE
		WHEN SeatNumber % 2 =0 THEN 'Even'
		ELSE 'Odd'
	END AS type,
	COUNT(*)
FROM SeatingChart
GROUP BY
	CASE
		WHEN SeatNumber % 2 =0 THEN 'Even'
		ELSE 'Odd'
	END
```
