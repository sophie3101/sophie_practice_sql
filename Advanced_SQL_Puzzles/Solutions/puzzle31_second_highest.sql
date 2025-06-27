DROP TABLE IF EXISTS SampleData;


CREATE TEMP TABLE SampleData
(
IntegerValue  INTEGER PRIMARY KEY
);


INSERT INTO SampleData (IntegerValue) VALUES
(3759),(3760),(3761),(3762),(3763);

--solution 1
SELECT *
FROM SampleData
ORDER BY IntegerValue DESC
LIMIT 1 OFFSET 1

--solution 2
SELECT *
FROM SampleData
WHERE integervalue  <>(SELECT MAX(IntegerValue) FROM SampleData)
ORDER BY IntegerValue DESC
LIMIT 1