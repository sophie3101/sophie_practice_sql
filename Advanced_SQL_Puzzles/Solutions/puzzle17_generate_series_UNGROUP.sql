DROP TABLE IF EXISTS Ungroup;


CREATE TEMP TABLE Ungroup
(
ProductDescription  VARCHAR(100) PRIMARY KEY,
Quantity            INTEGER NOT NULL
);


INSERT INTO Ungroup (ProductDescription, Quantity) VALUES
('Pencil',3),('Eraser',4),('Notebook',2);

-- My solution
SELECT ProductDescription, 1
FROM Ungroup
GROUP BY ProductDescription, GENERATE_SERIES(1, Quantity)

--Solution 2: use recursion
WITH RECURSIVE cte_Recursion AS
(
SELECT  ProductDescription,Quantity 
FROM    Ungroup
UNION ALL
SELECT  ProductDescription,Quantity-1 
FROM    cte_Recursion
WHERE   Quantity >= 2
    )
SELECT  ProductDescription,1 AS Quantity
FROM   cte_Recursion
ORDER BY ProductDescription DESC;