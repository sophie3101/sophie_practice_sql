You are employed by a company specializing in manufacturing various light bulbs. Each bulb is
composed of distinct components, each requiring a specific number of days for production, and these
components can be constructed independently.
Your task is to analyze a table of orders with their respective requested delivery dates and ascertain
whether each order can be completed and assembled by the specified delivery date
| Order ID | Component | Days to Deliver |
|----------|-----------|-----------------|
| 1 | Aurora | 7 |
| 2 | Twilight | 3 |
| 3 | SunRay | 9 |

| Product | Component       | Days to Manufacture |
| ------- | --------------- | ------------------- |
| Aurora  | Photon Coil     | 7                   |
| Aurora  | Filament        | 2                   |
| Aurora  | Shine Capacitor |                     |

EXPECTED
| Order ID | Product | Days to Build | Days to Deliver | Schedule |
|----------|----------|----------------|------------------|--------------------|
| 1 | Aurora | 7 | 7 | On Schedule |
| 2 | Twilight | 7 | 3 | Behind Schedule |
| 3 | SunRay | 3 | 9 | Ahead of Schedule |

SCHEMA

```
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

```

SOLUTION

```
WITH cte AS (
SELECT o.OrderID, o.Product, m.DaysToBuild, o.DaysToDeliver
FROM ORDERS o
JOIN (SELECT Product, Max(DaysToManufacture) as DaysToBuild FROM ManufacturingTimes GROUP BY Product) m
ON o.Product=m.Product

)

SELECT *,
CASE
WHEN DaysToBuild=DaysToDeliver THEN 'On Schedule'
WHEN DaysToBuild>DaysToDeliver THEN 'Behind Schedule'
ELSE 'Ahead of Schedule'
END
FROM Cte


```
