DROP TABLE IF EXISTS Employees;


CREATE TEMP TABLE Employees
(
EmployeeID  INTEGER,
License     VARCHAR(100),
PRIMARY KEY (EmployeeID, License)
);


INSERT INTO Employees (EmployeeID, License) VALUES
(1001,'Class A'),(1001,'Class B'),(1001,'Class C'),
(2002,'Class A'),(2002,'Class B'),(2002,'Class C'),
(3003,'Class A'),(3003,'Class D'),
(4004,'Class A'),(4004,'Class B'),(4004,'Class D'),
(5005,'Class A'),(5005,'Class B'),(5005,'Class D');

WITH cte AS (
SELECT e1.EmployeeID AS employeeIDA,
	   e2.EmployeeID AS employeeIDB,
	   COUNT(*) OVER (PARTITION BY e1.EmployeeID, e2.EmployeeID) AS license_count
FROM Employees e1
CROSS JOIN Employees e2 
WHERE e1.EmployeeID <> e2.EmployeeID 
	 AND e1.license = e2.license),
count_cte AS (
SELECT EmployeeID, COUNT(license)
FROM Employees
GROUP BY EmployeeID)

SELECT distinct cte.EmployeeIDA, cte.EmployeeIDB, cte.license_count
FROM cte 
JOIN count_cte 
ON count_cte.EmployeeID = cte.EmployeeIDA AND cte.license_count=count_cte.count 