-- Given a table of candidates and their skills, find the candidates who are best suited 
-- for a Data Science job requiring proficiency in:
--     - Python
--     - Tableau
--     - PostgreSQL

-- Assumptions:
--   - The candidates table has no duplicate rows.
--   - Each row represents one skill for a candidate.
--   - Candidates must have all three required skills to qualify.

-- Table: candidates
-- Columns:
--   candidate_id   INTEGER
--   skill          VARCHAR
SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) = 3
ORDER BY candidate_id;