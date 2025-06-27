DROP TABLE IF EXISTS SampleData;


CREATE TEMP TABLE SampleData
(
IntegerValue  INTEGER NOT NULL
);


INSERT INTO SampleData (IntegerValue) VALUES
(1),(1),(2),(3),(3),(4);

--solution 1
SELECT distinct Integervalue FROM SampleData;

--solution 2 using CTE
WITH cte AS (
	SELECT IntegerValue,
	ROW_NUMBER()OVER(PARTITION BY Integervalue ORDER BY IntegerValue) as rank
	FROM SampleData
)

SELECT IntegerValue
FROM cte
WHERE rank=1