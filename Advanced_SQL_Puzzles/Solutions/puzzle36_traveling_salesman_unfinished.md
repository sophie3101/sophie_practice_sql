Write an SQL statement that shows all the possible routes from Austin to Des Moines. Which route is
the most expensive? Which route is the least expensiv

| Route ID | Departure City | Arrival City | Cost |
| -------- | -------------- | ------------ | ---- |
| 1        | Austin         | Dallas       | $100 |
| 1        | Dallas         | Austin       | $100 |
| 2        | Dallas         | Memphis      | $200 |
| 2        | Memphis        | Dallas       | $200 |
| 3        | Memphis        | Des Moines   | $300 |
| 3        | Des Moines     | Memphis      | $300 |
| 4        | Dallas         | Des Moines   | $400 |
| 4        | Des Moines     | Dallas       | $400 |

EXPECTED
| Route Path | Total Cost |
|------------------------------------------|------------|
| Austin --> Dallas --> Des Moines | $500 |
| Austin --> Dallas --> Memphis --> Des Moines | $600 |

SCHEMA

```
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
```
