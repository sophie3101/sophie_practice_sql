DROP TABLE IF EXISTS Inventory;


CREATE TEMP TABLE Inventory
(
InventoryDate       DATE PRIMARY KEY,
QuantityAdjustment  INTEGER NOT NULL
);


INSERT INTO Inventory (InventoryDate, QuantityAdjustment) VALUES
('7/1/2018',100),('7/2/2018',75),('7/3/2018',-150),
('7/4/2018',50),('7/5/2018',-75);

SELECT *,
SUM(QuantityAdjustment) OVER(ORDER BY InventoryDate)
FROM Inventory