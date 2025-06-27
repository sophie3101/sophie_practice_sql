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

SELECT  OrderID, CustomerID, OrderDate, Amount, "State"
FROM    Orders
ORDER BY OrderID
OFFSET 4 ROWS 
FETCH NEXT 6 ROWS ONLY


--Syntax
SELECT column_name(s)

FROM table_name

ORDER BY column_name
OFFSET start_row_number ROWS
FETCH NEXT number_of_rows ROWS ONLY;