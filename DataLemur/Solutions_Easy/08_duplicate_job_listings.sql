-- Count the number of companies that have posted duplicate job listings.
-- Duplicate = same company_id, same title, same description (posted more than once)

-- Table: job_listings
-- Columns:
--   job_id       INTEGER
--   company_id   INTEGER
--   title        STRING
--   description  STRING
SELECT COUNT(DISTINCT company_id) FROM 
  (SELECT company_id
  FROM job_listings
  GROUP BY company_id, title, description
  HAVING COUNT(*) >1
  ) AS temp
