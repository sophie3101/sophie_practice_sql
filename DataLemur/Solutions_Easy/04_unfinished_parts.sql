-- Identify parts that have started the assembly process but are not yet finished.

-- Assumptions:
-- - Each row in parts_assembly represents a step in the assembly process.
-- - A part is considered unfinished if it has no finish_date for any step.
-- - The table contains only parts that are currently in production.

-- Table: parts_assembly
-- Columns:
--   part           STRING
--   finish_date    DATETIME (NULL if not yet completed)
--   assembly_step  INTEGER
SELECT part, assembly_step
FROM parts_assembly
WHERE finish_date IS NULL