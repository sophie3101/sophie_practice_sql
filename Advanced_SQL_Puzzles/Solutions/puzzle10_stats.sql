DROP TABLE IF EXISTS SampleData;


CREATE TEMP TABLE SampleData
(
IntegerValue  INTEGER NOT NULL
);


INSERT INTO SampleData (IntegerValue) VALUES
(5),(6),(10),(10),(13),(14),(17),(20),(81),(90),(76);

--finding mode
SELECT mode()
WITHIN GROUP(ORDER BY IntegerValue)
FROM SampleData

--or 
SELECT   IntegerValue
FROM SampleData
GROUP BY IntegerValue
ORDER BY COUNT(*) DESC
LIMIT 1

--findng mean
SELECT AVG(IntegerValue)
FROM SampleData

--finding median
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY IntegerValue)
FROM SampleData

--finding range

SELECT  MAX(IntegerValue) - MIN(IntegerValue) AS Range
FROM SampleData