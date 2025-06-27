DROP TABLE IF EXISTS Candidates;
DROP TABLE IF EXISTS Requirements;


CREATE TEMP TABLE Candidates
(
CandidateID  INTEGER,
Occupation   VARCHAR(100),
PRIMARY KEY (CandidateID, Occupation)
);


INSERT INTO Candidates (CandidateID, Occupation) VALUES
(1001,'Geologist'),(1001,'Astrogator'),(1001,'Biochemist'),
(1001,'Technician'),(2002,'Surgeon'),(2002,'Machinist'),
(3003,'Cryologist'),(4004,'Selenologist');


CREATE TEMP TABLE Requirements
(
Requirement  VARCHAR(100) PRIMARY KEY
);


INSERT INTO Requirements (Requirement) VALUES
('Geologist'),('Astrogator'),('Technician');


--Solution
SELECT distinct CandidateID
FROM Candidates 
WHERE Occupation IN (SELECT Requirement FROM Requirements);

--other solutions
SELECT  CandidateID
FROM    #Candidates
WHERE   Occupation IN (SELECT Requirement FROM #Requirements)
GROUP BY CandidateID
HAVING COUNT(*) = (SELECT COUNT(*) FROM #Requirements);
