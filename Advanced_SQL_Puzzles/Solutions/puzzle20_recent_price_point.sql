
--Write an SQL statement to determine the current price point for each product
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

WITH cte AS (
SELECT *,
RANK() OVER(PARTITION BY ProductID ORDER BY EffectiveDate DESC) as rank
FROM ValidPrices)

SELECT *
FROM cte
WHERE rank=1

--other solution
SELECT  ProductID,
        EffectiveDate,
        COALESCE(UnitPrice,0) AS UnitPrice
FROM    #ValidPrices AS pp
WHERE   NOT EXISTS (SELECT    1
                    FROM      #ValidPrices AS ppl
                    WHERE     ppl.ProductID = pp.ProductID AND
                              ppl.EffectiveDate > pp.EffectiveDate);