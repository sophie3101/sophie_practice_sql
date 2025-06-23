DROP TABLE IF EXISTS TestCases;


CREATE TEMP TABLE TestCases
(
TestCase  VARCHAR(1) PRIMARY KEY
);


INSERT INTO TestCases (TestCase) VALUES
('A'),('B'),('C');

-- no use of recursion
SELECT CONCAT_WS(',', t1.TestCase, t2.TestCase, t3.TestCase)
FROM TestCases t1, TestCases t2, TestCases t3
WHERE t1.TestCase <> t2.TestCase AND t2.TestCase <> t3.TestCase AND t1.TestCase <> t3.TestCase

--use recursion
WITH RECURSIVE Permutations(seq, used, depth) AS (
    -- Base case
    SELECT  TestCase::VARCHAR, TestCase::VARCHAR, 1
    FROM TestCases

    UNION ALL

    -- Recursive case
    SELECT p.seq || ',' || t.TestCase,
           p.used || t.TestCase,
           p.depth + 1
    FROM Permutations p
    JOIN TestCases t ON POSITION(t.TestCase IN p.used) = 0
    WHERE p.depth < 3
)

SELECT seq
FROM Permutations
WHERE depth = 3
ORDER BY seq;
