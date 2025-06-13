SELECT COUNT(DISTINCT company_id) FROM 
  (SELECT company_id
  FROM job_listings
  GROUP BY company_id, title, description
  HAVING COUNT(*) >1
  ) AS temp
