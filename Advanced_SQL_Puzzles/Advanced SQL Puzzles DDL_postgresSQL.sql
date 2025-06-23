/*----------------------------------------------------
DDL for Advanced SQL Puzzles
PostgresSQL
*/----------------------------------------------------

/*----------------------------------------------------
DDL for Puzzle 1
Shopping Carts
*/----------------------------------------------------

DROP TABLE IF EXISTS Cart1;
DROP TABLE IF EXISTS Cart2;


CREATE TEMP TABLE Cart1
(
Item  VARCHAR(100) PRIMARY KEY
);


CREATE TEMP TABLE Cart2
(
Item  VARCHAR(100) PRIMARY KEY
);


INSERT INTO Cart1 (Item) VALUES
('Sugar'),('Bread'),('Juice'),('Soda'),('Flour');


INSERT INTO Cart2 (Item) VALUES
('Sugar'),('Bread'),('Butter'),('Cheese'),('Fruit');


/*----------------------------------------------------
DDL for Puzzle 2
Managers and Employees
*/----------------------------------------------------

DROP TABLE IF EXISTS Employees;


CREATE TEMP TABLE Employees
(
EmployeeID  INTEGER PRIMARY KEY,
ManagerID   INTEGER NULL,
JobTitle    VARCHAR(100) NOT NULL
);


INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) VALUES
(1001,NULL,'President'),(2002,1001,'Director'),
(3003,1001,'Office Manager'),(4004,2002,'Engineer'),
(5005,2002,'Engineer'),(6006,2002,'Engineer');



/*----------------------------------------------------
DDL for Puzzle 3
Fiscal Year Table Constraints
*/----------------------------------------------------

DROP TABLE IF EXISTS EmployeePayRecords;


CREATE TEMP TABLE EmployeePayRecords
(
EmployeeID  INTEGER PRIMARY KEY,
FiscalYear  INTEGER CHECK(FIscalYear >=1900 AND FiscalYear<=2100),
StartDate   DATE NOT NULL CHECK(
    EXTRACT(DAY FROM StartDate)=1 AND EXTRACT(MONTH FROM StartDate) BETWEEN 1 AND 12
),
EndDate     DATE NOT NULL CHECK(
  EXTRACT(MONTH FROM StartDate) BETWEEN 1 AND 12
),
PayRate     MONEY NOT NULL
);


/*----------------------------------------------------
DDL for Puzzle 4
Two Predicates
*/----------------------------------------------------

DROP TABLE IF EXISTS Orders;


CREATE TEMP TABLE Orders
(
CustomerID     INTEGER,
OrderID        INTEGER,
DeliveryState  VARCHAR(100) NOT NULL,
Amount         MONEY NOT NULL,
PRIMARY KEY (CustomerID, OrderID)
);


INSERT INTO Orders (CustomerID, OrderID, DeliveryState, Amount) VALUES
(1001,1,'CA',340),(1001,2,'TX',950),(1001,3,'TX',670),
(1001,4,'TX',860),(2002,5,'WA',320),(3003,6,'CA',650),
(3003,7,'CA',830),(4004,8,'TX',120);


/*----------------------------------------------------
DDL for Puzzle 5
Phone Directory
*/----------------------------------------------------

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


/*----------------------------------------------------
DDL for Puzzle 6
Workflow Steps
*/----------------------------------------------------

DROP TABLE IF EXISTS WorkflowSteps;


CREATE TEMP TABLE WorkflowSteps
(
Workflow        VARCHAR(100),
StepNumber      INTEGER,
CompletionDate  DATE NULL,
PRIMARY KEY (Workflow, StepNumber)
);


INSERT INTO WorkflowSteps (Workflow, StepNumber, CompletionDate) VALUES
('Alpha',1,'7/2/2018'),('Alpha',2,'7/2/2018'),('Alpha',3,'7/1/2018'),
('Bravo',1,'6/25/2018'),('Bravo',2,NULL),('Bravo',3,'6/27/2018'),
('Charlie',1,NULL),('Charlie',2,'7/1/2018');


/*----------------------------------------------------
DDL for Puzzle 7
Mission to Mars
*/----------------------------------------------------

DROP TABLE IF EXISTS Candidates;
DROP TABLE IF EXISTS Requirements;


CREATE TEMP TABLE Candidates
(
CandidateID  INTEGER,
Occupation   VARCHAR(100),
PRIMARY KEY (CandidateID, Occupation)
);


INSERT INTO Candidates (CandidateID, Occupation) VALUES
(1001,'Geologist'),(1001,'Astrogator'),(1001,'Biochemist'),
(1001,'Technician'),(2002,'Surgeon'),(2002,'Machinist'),
(3003,'Cryologist'),(4004,'Selenologist');


CREATE TEMP TABLE Requirements
(
Requirement  VARCHAR(100) PRIMARY KEY
);


INSERT INTO Requirements (Requirement) VALUES
('Geologist'),('Astrogator'),('Technician');


/*----------------------------------------------------
DDL for Puzzle 8
Workflow Cases
*/----------------------------------------------------

DROP TABLE IF EXISTS WorkflowCases;


CREATE TEMP TABLE WorkflowCases
(
Workflow  VARCHAR(100) PRIMARY KEY,
Case1     INTEGER NOT NULL DEFAULT 0,
Case2     INTEGER NOT NULL DEFAULT 0,
Case3     INTEGER NOT NULL DEFAULT 0
);


INSERT INTO WorkflowCases (Workflow, Case1, Case2, Case3) VALUES
('Alpha',0,0,0),('Bravo',0,1,1),('Charlie',1,0,0),('Delta',0,0,0);


/*----------------------------------------------------
DDL for Puzzle 9
Matching Sets
*/----------------------------------------------------

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


/*----------------------------------------------------
DDL for Puzzle 10
Mean, Median, Mode and Range
*/----------------------------------------------------

DROP TABLE IF EXISTS SampleData;


CREATE TEMP TABLE SampleData
(
IntegerValue  INTEGER NOT NULL
);


INSERT INTO SampleData (IntegerValue) VALUES
(5),(6),(10),(10),(13),(14),(17),(20),(81),(90),(76);


/*----------------------------------------------------
DDL for Puzzle 11
Permutations
*/----------------------------------------------------

DROP TABLE IF EXISTS TestCases;


CREATE TEMP TABLE TestCases
(
TestCase  VARCHAR(1) PRIMARY KEY
);


INSERT INTO TestCases (TestCase) VALUES
('A'),('B'),('C');


/*----------------------------------------------------
DDL for Puzzle 12
Average Days
*/----------------------------------------------------

DROP TABLE IF EXISTS ProcessLog;


CREATE TEMP TABLE ProcessLog
(
WorkFlow       VARCHAR(100),
ExecutionDate  DATE,
PRIMARY KEY (WorkFlow, ExecutionDate)
);


INSERT INTO ProcessLog (WorkFlow, ExecutionDate) VALUES
('Alpha','6/01/2018'),('Alpha','6/14/2018'),('Alpha','6/15/2018'),
('Bravo','6/1/2018'),('Bravo','6/2/2018'),('Bravo','6/19/2018'),
('Charlie','6/1/2018'),('Charlie','6/15/2018'),('Charlie','6/30/2018');


/*----------------------------------------------------
DDL for Puzzle 13
Inventory Tracking
*/----------------------------------------------------

DROP TABLE IF EXISTS Inventory;


CREATE TEMP TABLE Inventory
(
InventoryDate       DATE PRIMARY KEY,
QuantityAdjustment  INTEGER NOT NULL
);


INSERT INTO Inventory (InventoryDate, QuantityAdjustment) VALUES
('7/1/2018',100),('7/2/2018',75),('7/3/2018',-150),
('7/4/2018',50),('7/5/2018',-75);


/*----------------------------------------------------
DDL for Puzzle 14
Indeterminate Process Log
*/----------------------------------------------------

DROP TABLE IF EXISTS ProcessLog;


CREATE TEMP TABLE ProcessLog
(
Workflow    VARCHAR(100),
StepNumber  INTEGER,
RunStatus   VARCHAR(100) NOT NULL,
PRIMARY KEY (Workflow, StepNumber)
);


INSERT INTO ProcessLog (Workflow, StepNumber, RunStatus) VALUES
('Alpha',1,'Error'),('Alpha',2,'Complete'),('Alpha',3,'Running'),
('Bravo',1,'Complete'),('Bravo',2,'Complete'),
('Charlie',1,'Running'),('Charlie',2,'Running'),
('Delta',1,'Error'),('Delta',2,'Error'),
('Echo',1,'Running'),('Echo',2,'Complete');


/*----------------------------------------------------
DDL for Puzzle 15
Group Concatenation
*/----------------------------------------------------

DROP TABLE IF EXISTS DMLTable;


CREATE TEMP TABLE DMLTable
(
SequenceNumber  INTEGER PRIMARY KEY,
String          VARCHAR(100) NOT NULL
);


INSERT INTO DMLTable (SequenceNumber, String) VALUES
(1,'SELECT'),
(2,'Product,'),
(3,'UnitPrice,'),
(4,'EffectiveDate'),
(5,'FROM'),
(6,'Products'),
(7,'WHERE'),
(8,'UnitPrice'),
(9,'> 100');


/*----------------------------------------------------
DDL for Puzzle 16
Reciprocals
*/----------------------------------------------------

DROP TABLE IF EXISTS PlayerScores;


CREATE TEMP TABLE PlayerScores
(
PlayerA  INTEGER,
PlayerB  INTEGER,
Score    INTEGER NOT NULL,
PRIMARY KEY (PlayerA, PlayerB)
);


INSERT INTO PlayerScores (PlayerA, PlayerB, Score) VALUES
(1001,2002,150),(3003,4004,15),(4004,3003,125);


/*----------------------------------------------------
DDL for Puzzle 17
De-Grouping
*/----------------------------------------------------

DROP TABLE IF EXISTS Ungroup;


CREATE TEMP TABLE Ungroup
(
ProductDescription  VARCHAR(100) PRIMARY KEY,
Quantity            INTEGER NOT NULL
);


INSERT INTO Ungroup (ProductDescription, Quantity) VALUES
('Pencil',3),('Eraser',4),('Notebook',2);


/*----------------------------------------------------
DDL for Puzzle 18
Seating Chart
*/----------------------------------------------------

DROP TABLE IF EXISTS SeatingChart;


CREATE TEMP TABLE SeatingChart
(
SeatNumber  INTEGER PRIMARY KEY
);


INSERT INTO SeatingChart (SeatNumber) VALUES
(7),(13),(14),(15),(27),(28),(29),(30),(31),(32),(33),(34),(35),(52),(53),(54);


/*----------------------------------------------------
DDL for Puzzle 19
Back to the Future
*/----------------------------------------------------

DROP TABLE IF EXISTS TimePeriods;


CREATE TEMP TABLE TimePeriods
(
StartDate  DATE,
EndDate    DATE,
PRIMARY KEY (StartDate, EndDate)
);


INSERT INTO TimePeriods (StartDate, EndDate) VALUES
('1/1/2018','1/5/2018'),
('1/3/2018','1/9/2018'),
('1/10/2018','1/11/2018'),
('1/12/2018','1/16/2018'),
('1/15/2018','1/19/2018');


/*----------------------------------------------------
DDL for Puzzle 20
Price Points
*/----------------------------------------------------

DROP TABLE IF EXISTS ValidPrices;


CREATE TEMP TABLE ValidPrices
(
ProductID      INTEGER,
UnitPrice      MONEY,
EffectiveDate  DATE,
PRIMARY KEY (ProductID, UnitPrice, EffectiveDate)
);


INSERT INTO ValidPrices (ProductID, UnitPrice, EffectiveDate) VALUES
(1001,1.99,'1/01/2018'),
(1001,2.99,'4/15/2018'),
(1001,3.99,'6/8/2018'),
(2002,1.99,'4/17/2018'),
(2002,2.99,'5/19/2018');


/*----------------------------------------------------
DDL for Puzzle 21
Average Monthly Sales
*/----------------------------------------------------

DROP TABLE IF EXISTS Orders;


CREATE TEMP TABLE Orders
(
OrderID     INTEGER PRIMARY KEY,
CustomerID  INTEGER NOT NULL,
OrderDate   DATE NOT NULL,
Amount      MONEY NOT NULL,
"State"     VARCHAR(2) NOT NULL
);


INSERT INTO Orders (OrderID, CustomerID, OrderDate, Amount, "State" ) VALUES
(1,1001,'1/1/2018',100,'TX'),
(2,1001,'1/1/2018',150,'TX'),
(3,1001,'1/1/2018',75,'TX'),
(4,1001,'2/1/2018',100,'TX'),
(5,1001,'3/1/2018',100,'TX'),
(6,2002,'2/1/2018',75,'TX'),
(7,2002,'2/1/2018',150,'TX'),
(8,3003,'1/1/2018',100,'IA'),
(9,3003,'2/1/2018',100,'IA'),
(10,3003,'3/1/2018',100,'IA'),
(11,4004,'4/1/2018',100,'IA'),
(12,4004,'5/1/2018',50,'IA'),
(13,4004,'5/1/2018',100,'IA');


/*----------------------------------------------------
DDL for Puzzle 22
Occurrences
*/----------------------------------------------------

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


/*----------------------------------------------------
DDL for Puzzle 23
Divide in Half
*/----------------------------------------------------

DROP TABLE IF EXISTS PlayerScores;


CREATE TEMP TABLE PlayerScores
(
PlayerID  INTEGER PRIMARY KEY,
Score     INTEGER NOT NULL
);


INSERT INTO PlayerScores (PlayerID, Score) VALUES
(1001,2343),(2002,9432),
(3003,6548),(4004,1054),
(5005,6832);


/*----------------------------------------------------
DDL for Puzzle 24
Page Views
*/----------------------------------------------------

DROP TABLE IF EXISTS Orders;


CREATE TEMP TABLE Orders
(
OrderID     INTEGER PRIMARY KEY,
CustomerID  INTEGER NOT NULL,
OrderDate   DATE NOT NULL,
Amount      MONEY NOT NULL,
"State"     VARCHAR(2) NOT NULL
);


INSERT INTO Orders (OrderID, CustomerID, OrderDate, Amount, "State" ) VALUES
(1,1001,'1/1/2018',100,'TX'),
(2,1001,'1/1/2018',150,'TX'),
(3,1001,'1/1/2018',75,'TX'),
(4,1001,'2/1/2018',100,'TX'),
(5,1001,'3/1/2018',100,'TX'),
(6,2002,'2/1/2018',75,'TX'),
(7,2002,'2/1/2018',150,'TX'),
(8,3003,'1/1/2018',100,'IA'),
(9,3003,'2/1/2018',100,'IA'),
(10,3003,'3/1/2018',100,'IA'),
(11,4004,'4/1/2018',100,'IA'),
(12,4004,'5/1/2018',50,'IA'),
(13,4004,'5/1/2018',100,'IA');


/*----------------------------------------------------
DDL for Puzzle 25
Top Vendors
*/----------------------------------------------------

DROP TABLE IF EXISTS Orders;


CREATE TEMP TABLE Orders
(
OrderID     INTEGER PRIMARY KEY,
CustomerID  INTEGER NOT NULL,
"Count"    MONEY NOT NULL,
Vendor      VARCHAR(100) NOT NULL
);


INSERT INTO Orders (OrderID, CustomerID,"Count", Vendor) VALUES
(1,1001,12,'Direct Parts'),
(2,1001,54,'Direct Parts'),
(3,1001,32,'ACME'),
(4,2002,7,'ACME'),
(5,2002,16,'ACME'),
(6,2002,5,'Direct Parts');


/*----------------------------------------------------
DDL for Puzzle 26
Previous Years Sales
*/----------------------------------------------------

DROP TABLE IF EXISTS Sales;


CREATE TEMP TABLE Sales
(
"Year"  INTEGER NOT NULL,
Amount  INTEGER NOT NULL
);


INSERT INTO Sales ("Year", Amount) VALUES
(EXTRACT(YEAR FROM CURRENT_DATE), 352645),
(EXTRACT(YEAR FROM (CURRENT_DATE - INTERVAL '1 year')), 165565),
(EXTRACT(YEAR FROM (CURRENT_DATE - INTERVAL '1 year')), 254654),
(EXTRACT(YEAR FROM (CURRENT_DATE - INTERVAL '2 years')), 159521),
(EXTRACT(YEAR FROM (CURRENT_DATE - INTERVAL '2 years')), 251696),
(EXTRACT(YEAR FROM (CURRENT_DATE - INTERVAL '3 years')), 111894);

/*----------------------------------------------------
DDL for Puzzle 27
Delete the Duplicates
*/----------------------------------------------------

DROP TABLE IF EXISTS SampleData;


CREATE TEMP TABLE SampleData
(
IntegerValue  INTEGER NOT NULL
);


INSERT INTO SampleData (IntegerValue) VALUES
(1),(1),(2),(3),(3),(4);


/*----------------------------------------------------
DDL for Puzzle 28
Fill the Gaps
*/----------------------------------------------------

DROP TABLE IF EXISTS Gaps;


CREATE TEMP TABLE Gaps
(
RowNumber   INTEGER PRIMARY KEY,
TestCase    VARCHAR(100) NULL
);


INSERT INTO Gaps (RowNumber, TestCase) VALUES
(1,'Alpha'),(2,NULL),(3,NULL),(4,NULL),
(5,'Bravo'),(6,NULL),(7,'Charlie'),(8,NULL),(9,NULL);


/*----------------------------------------------------
DDL for Puzzle 29
Count the Groupings
*/----------------------------------------------------
DROP TABLE IF EXISTS Groupings;


CREATE TEMP TABLE Groupings
(
StepNumber  INTEGER PRIMARY KEY,
TestCase    VARCHAR(100) NOT NULL,
Status    VARCHAR(100) NOT NULL
);


INSERT INTO Groupings (StepNumber, TestCase, Status) VALUES
(1,'Test Case 1','Passed'),
(2,'Test Case 2','Passed'),
(3,'Test Case 3','Passed'),
(4,'Test Case 4','Passed'),
(5,'Test Case 5','Failed'),
(6,'Test Case 6','Failed'),
(7,'Test Case 7','Failed'),
(8,'Test Case 8','Failed'),
(9,'Test Case 9','Failed'),
(10,'Test Case 10','Passed'),
(11,'Test Case 11','Passed'),
(12,'Test Case 12','Passed');


/*----------------------------------------------------
DDL for Puzzle 30
Select Star
*/----------------------------------------------------

DROP TABLE IF EXISTS Products;


CREATE TEMP TABLE Products
(
ProductID    INTEGER PRIMARY KEY,
ProductName  VARCHAR(100) NOT NULL
);


/*----------------------------------------------------
DDL for Puzzle 31
Second Highest
*/----------------------------------------------------

DROP TABLE IF EXISTS SampleData;


CREATE TEMP TABLE SampleData
(
IntegerValue  INTEGER PRIMARY KEY
);


INSERT INTO SampleData (IntegerValue) VALUES
(3759),(3760),(3761),(3762),(3763);


/*----------------------------------------------------
DDL for Puzzle 32
First and Last
*/----------------------------------------------------

DROP TABLE IF EXISTS Personal;


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


/*----------------------------------------------------
DDL for Puzzle 33
Deadlines
*/----------------------------------------------------

DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS ManufacturingTimes;


CREATE TEMP TABLE Orders
(
OrderID        INTEGER PRIMARY KEY,
Product        VARCHAR(100) NOT NULL,
DaysToDeliver  INTEGER NOT NULL
);


CREATE TEMP TABLE ManufacturingTimes
(
Product            VARCHAR(100),
Component          VARCHAR(100),
DaysToManufacture  INTEGER NOT NULL,
PRIMARY KEY (Product, Component)
);


INSERT INTO Orders (OrderID, Product, DaysToDeliver) VALUES
(1, 'Aurora', 7),
(2, 'Twilight', 3),
(3, 'SunRay', 9);


INSERT INTO ManufacturingTimes (Product, Component, DaysToManufacture) VALUES
('Aurora', 'Photon Coil', 7),
('Aurora', 'Filament', 2),
('Aurora', 'Shine Capacitor', 3),
('Aurora', 'Glow Sphere', 1),
('Twilight', 'Photon Coil', 7),
('Twilight', 'Filament', 2),
('SunRay', 'Shine Capacitor', 3),
('SunRay', 'Photon Coil', 1);


/*----------------------------------------------------
DDL for Puzzle 34
Specific Exclusion
*/----------------------------------------------------

DROP TABLE IF EXISTS Orders;


CREATE TEMP TABLE Orders
(
OrderID     INTEGER PRIMARY KEY,
CustomerID  INTEGER NOT NULL,
Amount      MONEY NOT NULL
);


INSERT INTO Orders (OrderID, CustomerID, Amount) VALUES
(1,1001,25),(2,1001,50),(3,2002,65),(4,3003,50);


/*----------------------------------------------------
DDL for Puzzle 35
International vs Domestic Sales
*/----------------------------------------------------

DROP TABLE IF EXISTS Orders;


CREATE TEMP TABLE Orders
(
InvoiceID   INTEGER PRIMARY KEY,
SalesRepID  INTEGER NOT NULL,
Amount      MONEY NOT NULL,
SalesType   VARCHAR(100) NOT NULL
);


/*----------------------------------------------------
DDL for Puzzle 36
Traveling Salesman
*/----------------------------------------------------

DROP TABLE IF EXISTS TravelingSalesman;
DROP TABLE IF EXISTS Routes;


CREATE TEMP TABLE Routes
(
RouteID        INTEGER NOT NULL,
DepartureCity  VARCHAR(30) NOT NULL,
ArrivalCity    VARCHAR(30) NOT NULL,
Cost           MONEY NOT NULL,
PRIMARY KEY (DepartureCity, ArrivalCity)
);


INSERT INTO Routes (RouteID, DepartureCity, ArrivalCity, Cost) VALUES
(1,'Austin','Dallas',100),
(2,'Dallas','Memphis',200),
(3,'Memphis','Des Moines',300),
(4,'Dallas','Des Moines',400);


/*----------------------------------------------------
DDL for Puzzle 37
Group Criteria Keys
*/----------------------------------------------------

DROP TABLE IF EXISTS GroupCriteria;


CREATE TEMP TABLE GroupCriteria
(
OrderID      INTEGER PRIMARY KEY,
Distributor  VARCHAR(100) NOT NULL,
Facility     INTEGER NOT NULL,
"Zone"      VARCHAR(100) NOT NULL,
Amount       MONEY NOT NULL
);


INSERT INTO GroupCriteria (OrderID, Distributor, Facility, "Zone", Amount) VALUES
(1,'ACME',123,'ABC',100),
(2,'ACME',123,'ABC',75),
(3,'Direct Parts',789,'XYZ',150),
(4,'Direct Parts',789,'XYZ',125);


/*----------------------------------------------------
DDL for Puzzle 38
Reporting Elements
*/----------------------------------------------------

DROP TABLE IF EXISTS RegionSales;


CREATE TEMP TABLE RegionSales
(
Region       VARCHAR(100),
Distributor  VARCHAR(100),
Sales        INTEGER NOT NULL,
PRIMARY KEY (Region, Distributor)
);


INSERT INTO RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10),
('South','ACE',67),
('East','ACE',54),
('North','ACME',65),
('South','ACME',9),
('East','ACME',1),
('West','ACME',7),
('North','Direct Parts',8),
('South','Direct Parts',7),
('West','Direct Parts',12);


/*----------------------------------------------------
DDL for Puzzle 39
Prime Numbers
*/----------------------------------------------------

DROP TABLE IF EXISTS PrimeNumbers;


CREATE TEMP TABLE PrimeNumbers
(
IntegerValue  INTEGER PRIMARY KEY
);


INSERT INTO PrimeNumbers (IntegerValue) VALUES
(1),(2),(3),(4),(5),(6),(7),(8),(9),(10);


/*----------------------------------------------------
DDL for Puzzle 40
Sort Order
*/----------------------------------------------------

DROP TABLE IF EXISTS SortOrder;


CREATE TEMP TABLE SortOrder
(
City  VARCHAR(100) PRIMARY KEY
);


INSERT INTO SortOrder (City) VALUES
('Atlanta'),('Baltimore'),('Chica'),('Denver');


/*----------------------------------------------------
DDL for Puzzle 41
Associate IDs
*/----------------------------------------------------

DROP TABLE IF EXISTS Associates;
DROP TABLE IF EXISTS Associates2;
DROP TABLE IF EXISTS Associates3;


CREATE TEMP TABLE Associates
(
Associate1  VARCHAR(100),
Associate2  VARCHAR(100),
PRIMARY KEY (Associate1, Associate2)
);


INSERT INTO Associates (Associate1, Associate2) VALUES
('Anne','Betty'),('Anne','Charles'),('Betty','Dan'),('Charles','Emma'),
('Francis','George'),('George','Harriet');


/*----------------------------------------------------
DDL for Puzzle 42
Mutual Friends
*/----------------------------------------------------

DROP TABLE IF EXISTS Friends;


CREATE TEMP TABLE Friends
(
Friend1  VARCHAR(100),
Friend2  VARCHAR(100),
PRIMARY KEY (Friend1, Friend2)
);


INSERT INTO Friends (Friend1, Friend2) VALUES
('Jason','Mary'),('Mike','Mary'),('Mike','Jason'),
('Susan','Jason'),('John','Mary'),('Susan','Mary');


/*----------------------------------------------------
DDL for Puzzle 43
Unbounded Preceding
*/----------------------------------------------------

DROP TABLE IF EXISTS CustomerOrders;


CREATE TEMP TABLE CustomerOrders
(
OrderID     INTEGER,
CustomerID  INTEGER,
Quantity    INTEGER NOT NULL,
PRIMARY KEY (OrderID, CustomerID)
);


INSERT INTO CustomerOrders (OrderID, CustomerID, Quantity) VALUES 
(1,1001,5),(2,1001,8),(3,1001,3),(4,1001,7),
(1,2002,4),(2,2002,9);


/*----------------------------------------------------
DDL for Puzzle 44
Slowly Changing Dimension Part I
*/----------------------------------------------------

DROP TABLE IF EXISTS Balances;


CREATE TEMP TABLE Balances
(
CustomerID   INTEGER,
BalanceDate  DATE,
Amount       MONEY NOT NULL,
PRIMARY KEY (CustomerID, BalanceDate)
);


INSERT INTO Balances (CustomerID, BalanceDate, Amount) VALUES
(1001,'10/11/2021',54.32),
(1001,'10/10/2021',17.65),
(1001,'9/18/2021',65.56),
(1001,'9/12/2021',56.23),
(1001,'9/1/2021',42.12),
(2002,'10/15/2021',46.52),
(2002,'10/13/2021',7.65),
(2002,'9/15/2021',75.12),
(2002,'9/10/2021',47.34),
(2002,'9/2/2021',11.11);


/*----------------------------------------------------
DDL for Puzzle 45
Slowly Changing Dimension Part 2
*/----------------------------------------------------

DROP TABLE IF EXISTS Balances;


CREATE TEMP TABLE Balances
(
CustomerID  INTEGER,
StartDate   DATE,
EndDate     DATE,
Amount      MONEY,
PRIMARY KEY (CustomerID, StartDate)
);


INSERT INTO Balances (CustomerID, StartDate, EndDate, Amount) VALUES
(1001,'10/11/2021','12/31/9999',54.32),
(1001,'10/10/2021','10/10/2021',17.65),
(1001,'9/18/2021','10/12/2021',65.56),
(2002,'9/12/2021','9/17/2021',56.23),
(2002,'9/1/2021','9/17/2021',42.12),
(2002,'8/15/2021','8/31/2021',16.32);


/*----------------------------------------------------
DDL for Puzzle 46
Positive Account Balances
*/----------------------------------------------------

DROP TABLE IF EXISTS AccountBalances;


CREATE TEMP TABLE AccountBalances
(
AccountID  INTEGER,
Balance    MONEY,
PRIMARY KEY (AccountID, Balance)
);


INSERT INTO AccountBalances (AccountID, Balance) VALUES
(1001,234.45),(1001,-23.12),(2002,-93.01),(2002,-120.19),
(3003,186.76), (3003,90.23), (3003,10.11);


/*----------------------------------------------------
DDL for Puzzle 47
Work Schedule
*/----------------------------------------------------

DROP TABLE IF EXISTS Schedule;
DROP TABLE IF EXISTS Activity;
DROP TABLE IF EXISTS ScheduleTimes;
DROP TABLE IF EXISTS ActivityCoalesce;


CREATE TEMP TABLE Schedule
(
ScheduleID  CHAR(1) PRIMARY KEY,
StartTime   TIMESTAMP NOT NULL ,
EndTime     TIMESTAMP NOT NULL
);


CREATE TEMP TABLE Activity
(
ScheduleID    CHAR(1) REFERENCES Schedule (ScheduleID),
ActivityName  VARCHAR(100),
StartTime     TIMESTAMP,
EndTime       TIMESTAMP,
PRIMARY KEY (ScheduleID, ActivityName, StartTime, EndTime)
);


INSERT INTO Schedule (ScheduleID, StartTime, EndTime) VALUES
('A',CAST('2021-10-01 10:00:00' AS TIMESTAMP),CAST('2021-10-01 15:00:00' AS TIMESTAMP)),
('B',CAST('2021-10-01 10:15:00' AS TIMESTAMP),CAST('2021-10-01 12:15:00' AS TIMESTAMP));


INSERT INTO Activity (ScheduleID, ActivityName, StartTime, EndTime) VALUES
('A','Meeting',CAST('2021-10-01 10:00:00' AS TIMESTAMP),CAST('2021-10-01 10:30:00' AS TIMESTAMP)),
('A','Break',CAST('2021-10-01 12:00:00' AS TIMESTAMP),CAST('2021-10-01 12:30:00' AS TIMESTAMP)),
('A','Meeting',CAST('2021-10-01 13:00:00' AS TIMESTAMP),CAST('2021-10-01 13:30:00' AS TIMESTAMP)),
('B','Break',CAST('2021-10-01 11:00:00'AS TIMESTAMP),CAST('2021-10-01 11:15:00' AS TIMESTAMP));


/*----------------------------------------------------
DDL for Puzzle 48
Consecutive Sales
*/----------------------------------------------------

DROP TABLE IF EXISTS Sales;


CREATE TEMP TABLE Sales
(
SalesID  INTEGER,
"Year"  INTEGER,
PRIMARY KEY (SalesID, "Year")
);


INSERT INTO Sales (SalesID, "Year") VALUES
(1001,2018),(1001,2019),(1001,2020),(2002,2020),(2002,2021),
(3003,2018),(3003,2020),(3003,2021),(4004,2019),(4004,2020),(4004,2021);


/*----------------------------------------------------
DDL for Puzzle 49
Sumo Wrestlers
*/----------------------------------------------------

DROP TABLE IF EXISTS ElevatorOrder;


CREATE TEMP TABLE ElevatorOrder
(
LineOrder  INTEGER PRIMARY KEY,
"Name"    VARCHAR(100) NOT NULL,
Weight   INTEGER NOT NULL
);


INSERT INTO ElevatorOrder ("Name" , Weight, LineOrder)
VALUES
('Haruto',611,1),('Minato',533,2),('Haruki',623,3),
('Sota',569,4),('Aoto',610,5),('Hinata',525,6);


/*----------------------------------------------------
DDL for Puzzle 50
Baseball Balls and Strikes
*/----------------------------------------------------

DROP TABLE IF EXISTS Pitches;


CREATE TEMP TABLE Pitches
(
BatterID     INTEGER,
PitchNumber  INTEGER,
Result       VARCHAR(100) NOT NULL,
PRIMARY KEY (BatterID, PitchNumber)
);


INSERT INTO Pitches (BatterID, PitchNumber, Result) VALUES
(1001,1,'Foul'), (1001,2,'Foul'),(1001,3,'Ball'),(1001,4,'Ball'),(1001,5,'Strike'),
(2002,1,'Ball'),(2002,2,'Strike'),(2002,3,'Foul'),(2002,4,'Foul'),(2002,5,'Foul'),
(2002,6,'In Play'),(3003,1,'Ball'),(3003,2,'Ball'),(3003,3,'Ball'),
(3003,4,'Ball'),(4004,1,'Foul'),(4004,2,'Foul'),(4004,3,'Foul'),
(4004,4,'Foul'),(4004,5,'Foul'),(4004,6,'Strike');


/*----------------------------------------------------
DDL for Puzzle 51
Primary Key Creation
*/----------------------------------------------------

DROP TABLE IF EXISTS Assembly;


CREATE TEMP TABLE Assembly
(
AssemblyID  INTEGER,
Part        VARCHAR(100),
PRIMARY KEY (AssemblyID, Part)
);


INSERT INTO Assembly (AssemblyID, Part) VALUES
(1001,'Bolt'),(1001,'Screw'),(2002,'Nut'),
(2002,'Washer'),(3003,'Toggle'),(3003,'Bolt');


/*----------------------------------------------------
DDL for Puzzle 52
Phone Numbers Table
*/----------------------------------------------------

/*
No DDL provided

You are creating a table that customer agents will use to enter customer information and their phone numbers.
Create a table with the fields Customer ID and Phone Number, where the Phone Number field must be inserted with the format (999)-999-9999.
Agents will enter phone numbers into this table via a form, and it is imperative that phone numbers are formatted correctly when inputted.  
Create a table that meets these requirements. 
*/

/*----------------------------------------------------
DDL for Puzzle 53
Spouse IDs
*/----------------------------------------------------

DROP TABLE IF EXISTS Spouses;


CREATE TEMP TABLE Spouses
(
PrimaryID  VARCHAR(100),
SpouseID   VARCHAR(100),
PRIMARY KEY (PrimaryID, SpouseID)
);


INSERT INTO Spouses (PrimaryID, SpouseID) VALUES
('Pat','Charlie'),('Jordan','Casey'),
('Ashley','Dee'),('Charlie','Pat'),
('Casey','Jordan'),('Dee','Ashley');


/*----------------------------------------------------
DDL for Puzzle 54
Winning Numbers
*/----------------------------------------------------

DROP TABLE IF EXISTS WinningNumbers;
DROP TABLE IF EXISTS LotteryTickets;


CREATE TEMP TABLE WinningNumbers
(
Number  INTEGER PRIMARY KEY
);


INSERT INTO WinningNumbers (Number) VALUES
(25),(45),(78);


CREATE TEMP TABLE LotteryTickets
(
TicketID  VARCHAR(3),
Number    INTEGER,
PRIMARY KEY (TicketID, Number)
);


INSERT INTO LotteryTickets (TicketID, Number) VALUES
('AAA',25),('AAA',45),('AAA',78),
('BBB',25),('BBB',45),('BBB',98),
('CCC',67),('CCC',86),('CCC',91);


/*----------------------------------------------------
DDL for Puzzle 55
Table Audit
*/----------------------------------------------------

DROP TABLE IF EXISTS ProductsA;
DROP TABLE IF EXISTS ProductsB;


CREATE TEMP TABLE ProductsA
(
ProductName  VARCHAR(100) PRIMARY KEY,
Quantity     INTEGER NOT NULL
);


CREATE TEMP TABLE ProductsB
(
ProductName  VARCHAR(100) PRIMARY KEY,
Quantity     INTEGER NOT NULL
);


INSERT INTO ProductsA (ProductName, Quantity) VALUES
('Widget',7),
('Doodad',9),
('Gizmo',3);


INSERT INTO ProductsB (ProductName, Quantity) VALUES
('Widget',7),
('Doodad',6),
('Dingbat',9);


/*----------------------------------------------------
DDL for Puzzle 56
Numbers Using Recursion
*/----------------------------------------------------

/*
No DDL provided

Create a numbers table using recursion
*/

/*----------------------------------------------------
DDL for Puzzle 57
Find The Spaces
*/----------------------------------------------------

DROP TABLE IF EXISTS Strings;


CREATE TEMP TABLE Strings
(
QuoteId   INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
String   VARCHAR(100) NOT NULL
);


INSERT INTO Strings (String) VALUES
('SELECT EmpID FROM Employees;'),('SELECT * FROM Transactions;');


/*----------------------------------------------------
DDL for Puzzle 58
Add Them Up
*/----------------------------------------------------

DROP TABLE IF EXISTS Equations;


CREATE TEMP TABLE Equations
(
Equation  VARCHAR(200) PRIMARY KEY,
TotalSum  INT NULL
);


INSERT INTO Equations (Equation) VALUES
('123'),('1+2+3'),('1+2-3'),('1+23'),('1-2+3'),('1-2-3'),('1-23'),('12+3'),('12-3');


/*----------------------------------------------------
DDL for Puzzle 59
Balanced String
*/----------------------------------------------------

DROP TABLE IF EXISTS BalancedString;


CREATE TEMP TABLE BalancedString
(
RowNumber        INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
ExpectedOutcome  VARCHAR(50),
MatchString      VARCHAR(50),
UpdateString     VARCHAR(50)
);


INSERT INTO BalancedString (ExpectedOutcome, MatchString) VALUES
('Balanced','( )'),
('Balanced','[]'),
('Balanced','{}'),
('Balanced','( ( { [] } ) )'),
('Balanced','( ) [ ]'),
('Balanced','( { } )'),
('Unbalanced','( { ) }'),
('Unbalanced','( { ) }}}()'),
('Unbalanced','}{()][');


/*----------------------------------------------------
DDL for Puzzle 60
Products Without Duplicates
*/----------------------------------------------------

DROP TABLE IF EXISTS Products;


CREATE TEMP TABLE Products
(
Product      VARCHAR(10),
ProductCode  VARCHAR(2),
PRIMARY KEY (Product, ProductCode)
);


INSERT INTO Products (Product, ProductCode) VALUES
('Alpha','01'),
('Alpha','02'),
('Bravo','03'),
('Bravo','04'),
('Charlie','02'),
('Delta','01'),
('Echo','EE'),
('Foxtrot','EE'),
('Gulf','GG');


/*----------------------------------------------------
DDL for Puzzle 61
Player Scores
*/----------------------------------------------------

DROP TABLE IF EXISTS PlayerScores;


CREATE TEMP TABLE PlayerScores
(
AttemptID  INTEGER,
PlayerID   INTEGER,
Score      INTEGER,
PRIMARY KEY (AttemptID, PlayerID)
);


INSERT INTO PlayerScores (AttemptID, PlayerID, Score) VALUES
(1,1001,2),(2,1001,7),(3,1001,8),(1,2002,6),(2,2002,9),(3,2002,7);


/*----------------------------------------------------
DDL for Puzzle 62
Car and Boat Purchase
*/----------------------------------------------------

DROP TABLE IF EXISTS Vehicles;


CREATE TEMP TABLE Vehicles (
VehicleID  INTEGER PRIMARY KEY,
"Type"     VARCHAR(20),
Model      VARCHAR(20),
Price      MONEY
);


INSERT INTO Vehicles (VehicleID, "Type", Model, Price) VALUES
(1, 'Car','Rolls-Royce Phantom', 460000),
(2, 'Car','Cadillac CT5', 39000),
(3, 'Car','Porsche Boxster', 63000),
(4, 'Car','Lamborghini Spyder', 290000),
(5, 'Boat','Malibu', 210000),
(6, 'Boat', 'ATX 22-S', 85000),
(7, 'Boat', 'Sea Ray SLX', 520000),
(8, 'Boat', 'Mastercraft', 25000);


/*----------------------------------------------------
DDL for Puzzle 63
Promotions
*/----------------------------------------------------

DROP TABLE IF EXISTS Promotions;


CREATE TEMP TABLE Promotions (
OrderID   INTEGER NOT NULL,
Product   VARCHAR(255) NOT NULL,
Discount  VARCHAR(255)
);


INSERT INTO Promotions (OrderID, Product, Discount) VALUES 
(1, 'Item1', 'PROMO'),
(1, 'Item1', 'PROMO'),
(1, 'Item1', 'MARKDOWN'),
(1, 'Item2', 'PROMO'),
(2, 'Item2', NULL),
(2, 'Item3', 'MARKDOWN'),
(2, 'Item3', NULL),
(3, 'Item1', 'PROMO'),
(3, 'Item1', 'PROMO'),
(3, 'Item1', 'PROMO');


/*----------------------------------------------------
DDL for Puzzle 64
Between Quotes
*/----------------------------------------------------

DROP TABLE IF EXISTS Strings;


CREATE TEMP TABLE Strings
(
ID      INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
String  VARCHAR(256) NOT NULL
);


INSERT INTO Strings (String) VALUES
('"12345678901234"'),
('1"2345678901234"'),
('123"45678"901234"'),
('123"45678901234"'),
('12345678901"234"'),
('12345678901234');

       
/*----------------------------------------------------
DDL for Puzzle 65
Home Listings
*/----------------------------------------------------
       
DROP TABLE IF EXISTS HomeListings;


CREATE TEMP TABLE HomeListings
(
ListingID  INTEGER PRIMARY KEY,
HomeID     VARCHAR(100),
Status     VARCHAR(100)
);


INSERT INTO HomeListings (ListingID, HomeID, Status) VALUES 
(1, 'Home A', 'New Listing'),
(2, 'Home A', 'Pending'),
(3, 'Home A', 'Relisted'),
(4, 'Home B', 'New Listing'),
(5, 'Home B', 'Under Contract'),
(6, 'Home B', 'Relisted'),
(7, 'Home C', 'New Listing'),
(8, 'Home C', 'Under Contract'),
(9, 'Home C', 'Closed');


/*----------------------------------------------------
DDL for Puzzle 66
Matching Parts
*/----------------------------------------------------

DROP TABLE IF EXISTS Parts;


CREATE TEMP TABLE Parts 
(
SerialNumber    VARCHAR(100) PRIMARY KEY,
ManufactureDay  INTEGER,
Product         VARCHAR(100)
);


INSERT INTO Parts (SerialNumber, ManufactureDay, Product) VALUES 
('A111', 1, 'Bolt'),
('B111', 3, 'Bolt'),
('C111', 5, 'Bolt'),
('D222', 2, 'Washer'),
('E222', 4, 'Washer'),
('F222', 6, 'Washer'),
('G333', 3, 'Nut'),
('H333', 5, 'Nut'),
('I333', 7, 'Nut');


/*----------------------------------------------------
DDL for Puzzle 67
Matching Birthdays
*/----------------------------------------------------

DROP TABLE IF EXISTS Students;


CREATE TEMP TABLE Students
(
StudentName  VARCHAR(50) PRIMARY KEY,
Birthday     DATE
);


INSERT INTO Students (StudentName, Birthday) VALUES 
('Susan', '2015-04-15'),
('Tim', '2015-04-15'),
('Jacob', '2015-04-15'),
('Earl', '2015-02-05'),
('Mike', '2015-05-23'),
('Angie', '2015-05-23'),
('Jenny', '2015-11-19'),
('Michelle', '2015-12-12'),
('Aaron', '2015-12-18');


/*----------------------------------------------------
DDL for Puzzle 68
Removing Outliers
*/----------------------------------------------------

DROP TABLE IF EXISTS Teams;


CREATE TEMP TABLE Teams (
Team    VARCHAR(50),
Year  INTEGER,
Score   INTEGER,
PRIMARY KEY (Team, Year)
);


INSERT INTO Teams (Team, Year, Score) VALUES
('Cougars', 2015, 50),
('Cougars', 2016, 45),
('Cougars', 2017, 65),
('Cougars', 2018, 92),
('Bulldogs', 2015, 65),
('Bulldogs', 2016, 60),
('Bulldogs', 2017, 58),
('Bulldogs', 2018, 12);


/*----------------------------------------------------
DDL for Puzzle 69
Splitting a Hierarchy
*/----------------------------------------------------

DROP TABLE IF EXISTS OrganizationChart;


CREATE TEMP TABLE OrganizationChart
(
ManagerID   CHAR(1),
EmployeeID  CHAR(1) NOT NULL PRIMARY KEY
);


INSERT INTO OrganizationChart (ManagerID, EmployeeID) VALUES
(NULL, 'A'),
('A', 'B'),
('A', 'C'),
('B', 'D'),
('B', 'E'),
('D', 'G'),
('C', 'F');


/*----------------------------------------------------
DDL for Puzzle 70
Student Facts
*/----------------------------------------------------

DROP TABLE IF EXISTS Students;


CREATE TEMP TABLE Students
(
ParentID  INTEGER NOT NULL,
ChildID   CHAR(1) PRIMARY KEY,
Age       INTEGER NOT NULL,
Gender    CHAR(1) NOT NULL
);


INSERT INTO Students (ParentID, ChildID, Age, Gender) VALUES
(1001, 'A', 8, 'M'),
(1001, 'B', 12, 'F'),
(2002, 'C', 7, 'F'),
(2002, 'D', 9, 'F'),
(2002, 'E', 14, 'M'),
(3003, 'F', 12, 'F'),
(3003, 'G', 14, 'M'),
(4004, 'H', 7, 'M');


/*----------------------------------------------------
DDL for Puzzle 71
Employee Validation
*/----------------------------------------------------

--Note this puzzle uses permanent tables
--Setting the database to use "test" to avoid possible issues

-- USE test;


DROP TABLE IF EXISTS TemporaryEmployees;
DROP TABLE IF EXISTS PermanentEmployees;
DROP TABLE IF EXISTS Employees;


CREATE TEMP TABLE TemporaryEmployees
(
EmployeeID  INTEGER PRIMARY KEY,
Department  VARCHAR(50) NOT NULL
);


CREATE TEMP TABLE PermanentEmployees
(
EmployeeID  INTEGER PRIMARY KEY,
Department  VARCHAR(50) NOT NULL
);


CREATE TEMP TABLE Employees
(
EmployeeID  INTEGER PRIMARY KEY,
Name     VARCHAR(50) NOT NULL
);


INSERT INTO TemporaryEmployees (EmployeeID, Department) VALUES
(1001, 'Engineering'),
(2002, 'Sales'),
(3003, 'Marketing');


INSERT INTO PermanentEmployees (EmployeeID, Department) VALUES
(4004, 'Marketing'),
(5005, 'Accounting'),
(6006, 'Accounting');


INSERT INTO Employees (EmployeeID, Name) VALUES
(1001, 'John'),
(2002, 'Eric'),
(3003, 'Jennifer'),
(4004, 'Bob'),
(5005, 'Stuart'),
(6006, 'Angie');


/*----------------------------------------------------
DDL for Puzzle 72
Under Warranty
*/----------------------------------------------------

DROP TABLE IF EXISTS Repairs;


CREATE TEMP TABLE Repairs (
RepairID    INTEGER PRIMARY KEY,
CustomerID  CHAR(1) NOT NULL,
RepairDate  DATE NOT NULL
);


INSERT INTO Repairs (RepairID, CustomerID, RepairDate) VALUES
(1001,'A','2023-01-01'),
(2002,'A','2023-01-15'),
(3003,'A','2023-01-17'),
(4004,'A','2023-03-24'),
(5005,'A','2023-04-01'),
(6006,'B','2023-06-22'),
(7007,'B','2023-06-23'),
(8008,'B','2023-09-01');


/*----------------------------------------------------
DDL for Puzzle 73
Distinct Statuses
*/----------------------------------------------------
DROP TABLE IF EXISTS WorkflowSteps;


CREATE TEMP TABLE WorkflowSteps
(
StepID    INTEGER PRIMARY KEY,
Workflow  VARCHAR(50),
Status  VARCHAR(50)
);


INSERT INTO WorkflowSteps (StepID, Workflow, Status) VALUES
(1, 'Alpha', 'Open'),
(2, 'Alpha', 'Open'),
(3, 'Alpha', 'Inactive'),
(4, 'Alpha', 'Open'),
(5, 'Bravo', 'Closed'),
(6, 'Bravo', 'Closed'),
(7, 'Bravo', 'Open'),
(8, 'Bravo', 'Inactive');


/*----------------------------------------------------
DDL for Puzzle 74
Bowling League
*/----------------------------------------------------
DROP TABLE IF EXISTS BowlingResults;


CREATE TEMP TABLE BowlingResults 
(
GameID  INTEGER,
Bowler  VARCHAR(50),
Score   INTEGER,
PRIMARY KEY (GameID, Bowler)
);


INSERT INTO BowlingResults (GameID, Bowler, Score) VALUES
(1, 'John', 167),
(1, 'Susan', 139),
(1, 'Ralph', 95),
(1, 'Mary', 90),
(2, 'Susan', 187),
(2, 'John', 155),
(2, 'Dennis', 100),
(2, 'Anthony', 78);


/*----------------------------------------------------
DDL for Puzzle 75
Symmetric Matches
*/----------------------------------------------------
DROP TABLE IF EXISTS Boxes;


CREATE TEMP TABLE Boxes 
(
Box      CHAR(1),
Length INTEGER,
Width    INTEGER,
Height   INTEGER
);


INSERT INTO Boxes (Box, Length, Width, Height) VALUES
('A', 10, 25, 15),
('B', 15, 10, 25),
('C', 10, 15, 25),
('D', 20, 30, 30),
('E', 30, 30, 20);


/*----------------------------------------------------
DDL for Puzzle 76
Determine Batches
*/----------------------------------------------------
DROP TABLE IF EXISTS BatchStarts;
DROP TABLE IF EXISTS BatchLines;


CREATE TEMP TABLE BatchStarts
(
Batch       CHAR(1),
BatchStart  INTEGER,
PRIMARY KEY (Batch, BatchStart)
);


CREATE TEMP TABLE BatchLines
(
Batch   CHAR(1),
Line    INTEGER,
Syntax  VARCHAR,-- VARCHAR without a length behaves like TEXT (unlimited length)
PRIMARY KEY (Batch, Line)
);


INSERT INTO BatchStarts (Batch, BatchStart) VALUES
('A', 1),
('A', 5);


INSERT INTO BatchLines (Batch, Line, Syntax) VALUES
('A', 1, 'SELECT *'),
('A', 2, 'FROM Account;'),
('A', 3, ''),
('A', 4, ''),
('A', 5, 'TRUNCATE TABLE Accounts;'),
('A', 6, '');


/*----------------------------------------------------
DDL for Puzzle 77
Temperature Readings
*/----------------------------------------------------
DROP TABLE IF EXISTS TemperatureData;


CREATE TEMP TABLE TemperatureData
(
TempID     INTEGER PRIMARY KEY,
TempValue  INTEGER NULL
);


INSERT INTO TemperatureData (TempID, TempValue) VALUES
(1,52),(2,NULL),(3,NULL),(4,65),(5,NULL),(6,72),
(7,NULL),(8,70),(9,NULL),(10,75),(11,NULL),(12,80);


/*----------------------------------------------------
The End
*/----------------------------------------------------
