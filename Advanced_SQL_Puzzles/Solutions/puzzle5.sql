DROP TABLE IF EXISTS PhoneDirectory;


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

SELECT
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