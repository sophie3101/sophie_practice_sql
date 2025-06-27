DROP TABLE IF EXISTS Orders;

| Order ID | Customer ID | Count | Vendor       |
| -------- | ----------- | ----- | ------------ |
| 1        | 1001        | 12    | Direct Parts |
| 2        | 1001        | 54    | Direct Parts |
| 3        | 1001        | 32    | ACME         |
| 4        | 2002        | 7     | ACME         |
| 5        | 2002        | 16    | ACME         |
| 6        | 2002        | 5     | Direct Parts |

EXPECTED
| Customer ID | Vendor |
|-------------|--------------|
| 1001 | Direct Parts |
| 2002 | ACME |

SCHEMA

```
CREATE TEMP TABLE Orders
(
OrderID     INTEGER PRIMARY KEY,
CustomerID  INTEGER NOT NULL,
"Count"    INTEGER NOT NULL,
Vendor      VARCHAR(100) NOT NULL
);
INSERT INTO Orders (OrderID, CustomerID,"Count", Vendor) VALUES
(1,1001,12,'Direct Parts'),
(2,1001,54,'Direct Parts'),
(3,1001,32,'ACME'),
(4,2002,7,'ACME'),
(5,2002,16,'ACME'),
(6,2002,5,'Direct Parts');
```

SOLUTION

```
SELECT CustomerID, Vendor
FROM (
SELECT *,
RANK() OVER( PARTITION BY CustomerID ORDER BY "Count" DESC)
FROM Orders) AS temp
WHERE rank=1

--other solution
SELECT *
FROM Orders o
WHERE "Count" = (
SELECT
MAX("Count")
FROM Orders
WHERE CustomerID = o.CustomerID
)
```
