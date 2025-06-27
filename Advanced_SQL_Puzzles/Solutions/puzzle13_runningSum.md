You work for a manufacturing company and need to track inventory adjustments from the warehouse.
Some days the inventory increases, on other days the inventory decreases.
Write an SQL statement that will provide a running balance of the inventory

expected output:
| Date | Quantity | Adjustment | Inventory |
|----------|----------|------------|-----------|
| 7/1/2018 | 100 | | 100 |
| 7/2/2018 | 75 | | 175 |
| 7/3/2018 | -150 | | 25 |
| 7/4/2018 | 50 | | 75 |
| 7/5/2018 | -100 | | -25 |

SCHEMA:

```
DROP TABLE IF EXISTS Inventory;


CREATE TEMP TABLE Inventory
(
InventoryDate       DATE PRIMARY KEY,
QuantityAdjustment  INTEGER NOT NULL
);


INSERT INTO Inventory (InventoryDate, QuantityAdjustment) VALUES
('7/1/2018',100),('7/2/2018',75),('7/3/2018',-150),
('7/4/2018',50),('7/5/2018',-75);
```

SOLUTION

```
SELECT *,
SUM(QuantityAdjustment) OVER(ORDER BY InventoryDate)
FROM Inventory
```
