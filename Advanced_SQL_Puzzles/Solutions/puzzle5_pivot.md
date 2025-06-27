Your customer phone directory table allows individuals to set up a home, cellular, or work phone
number.
Write an SQL statement to transform the following table into the expected output.
Table
| Customer ID | Type | Phone Number |
|-------------|----------|----------------|
| 1001 | Cellular | 555-897-5421 |
| 1001 | Work | 555-897-6542 |
| 1001 | Home | 555-698-9874 |
| 2002 | Cellular | 555-963-6544 |
| 2002 | W

expected output:
| Customer ID | Home | Cellular | Work |
|-------------|--------------|---------------|---------------|
| 1001 | 555-698-9874 | 555-897-5421 | 555-897-6542 |
| 2002 | | 555-963-6544 | 555-812-9856 |
| 3003 | | 555-987-6541 | |

```DROP TABLE IF EXISTS PhoneDirectory;
CREATE TEMP TABLE PhoneDirectory
(
CustomerID   INTEGER,
"Type"       VARCHAR(100),
PhoneNumber  VARCHAR(12) NOT NULL,
PRIMARY KEY (CustomerID, "Type")
);


INSERT INTO PhoneDirectory (CustomerID, "Type", PhoneNumber) VALUES
(1001,'Cellular','555-897-5421'),
(1001,'Work','555-897-6542'),
(1001,'Home','555-698-9874'),
(2002,'Cellular','555-963-6544'),
(2002,'Work','555-812-9856'),
(3003,'Cellular','555-987-6541');
```

Solution

```SELECT
    customerid,
    MAX(CASE WHEN "Type" = 'Cellular' THEN phonenumber END) AS Cellular,
    MAX(CASE WHEN "Type" = 'Work' THEN phonenumber END) AS Work,
    MAX(CASE WHEN "Type" = 'Home' THEN phonenumber END) AS Home
FROM PhoneDirectory
GROUP BY customerid
ORDER BY customerid


--Other Solution
WITH cte_Cellular AS
(
SELECT  CustomerID, PhoneNumber AS Cellular
FROM    #PhoneDirectory
WHERE   [Type] = 'Cellular'
),
cte_Work AS
(
SELECT  CustomerID, PhoneNumber AS Work
FROM    #PhoneDirectory
WHERE   [Type] = 'Work'
),
cte_Home AS
(
SELECT  CustomerID, PhoneNumber AS Home
FROM    #PhoneDirectory
WHERE   [Type] = 'Home'
)
SELECT  a.CustomerID,
        b.Cellular,
        c.Work,
        d.Home
FROM    (SELECT DISTINCT CustomerID FROM #PhoneDirectory) a LEFT OUTER JOIN
        cte_Cellular b ON a.CustomerID = b.CustomerID LEFT OUTER JOIN
        cte_Work c ON a.CustomerID = c.CustomerID LEFT OUTER JOIN
        cte_Home d ON a.CustomerID = d.CustomerID;
```

BONUS: IF I WANT TO UNPIVOT

```WITH pivot_cte AS (SELECT
    customerid,
    MAX(CASE WHEN "Type" = 'Cellular' THEN phonenumber END) AS Cellular,
    MAX(CASE WHEN "Type" = 'Work' THEN phonenumber END) AS Work,
    MAX(CASE WHEN "Type" = 'Home' THEN phonenumber END) AS Home
FROM PhoneDirectory
GROUP BY customerid
ORDER BY customerid
)

SELECT pivot_cte.customerid, t.*
FROM pivot_cte
CROSS JOIN LATERAL (
	VALUES
	('Cellular', pivot_cte.cellular),
	('Work', pivot_cte.Work),
	('Home', pivot_cte.Home)
) AS t
```
