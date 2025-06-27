You work in a sales office that sells widgets both domestically and internationally.
Write an SQL statement that shows all sales representatives who either had a domestic sale or an
international sale, but not both

| Invoice ID | Sales Rep ID | Amount   | Sales Type    |
| ---------- | ------------ | -------- | ------------- |
| 1          | 1001         | $13,454  | International |
| 2          | 2002         | $3,434   | International |
| 3          | 4004         | $54,645  | International |
| 4          | 5005         | $234,345 | International |
| 5          | 7007         | $776     | International |
| 6          | 1001         | $4,564   | Domestic      |
| 7          | 2002         | $34,534  | Domestic      |
| 8          | 3003         | $345     | Domestic      |
| 9          | 6006         | $6,543   | Domestic      |
| 10         | 8008         | $67      | Domestic      |

EXPECTED
| Sales Rep ID |
|--------------|
| 3003 |
| 4004 |
| 5005 |
| 6006 |

SCHEMA

```
DROP TABLE IF EXISTS Orders;

CREATE TEMP TABLE Orders
(
    InvoiceID   INTEGER PRIMARY KEY,
    SalesRepID  INTEGER NOT NULL,
    Amount      MONEY NOT NULL,
    SalesType   VARCHAR(100) NOT NULL
);

INSERT INTO Orders (InvoiceID, SalesRepID, Amount, SalesType) VALUES
(1, 1001, '$13,454', 'International'),
(2, 2002, '$3,434', 'International'),
(3, 4004, '$54,645', 'International'),
(4, 5005, '$234,345', 'International'),
(5, 7007, '$776', 'International'),
(6, 1001, '$4,564', 'Domestic'),
(7, 2002, '$34,534', 'Domestic'),
(8, 3003, '$345', 'Domestic'),
(9, 6006, '$6,543', 'Domestic'),
(10, 8008, '$67', 'Domestic');

```

MY SOLUTION

```
SELECT SalesRepID
FROM Orders
GROUP BY SalesRepID
HAVING COUNT(distinct SalesType) =1
```
