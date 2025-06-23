WITH cte AS (
  SELECT 
    workflow,
    CAST(STRING_AGG(distinct RunStatus, ',') AS VARCHAR(1000)) AS status
  FROM ProcessLog
  GROUP BY workflow
)
SELECT *,
CASE 
	WHEN cardinality(string_to_array(status,',')) = 3 THEN 'Indeterminate'
	WHEN cardinality(string_to_array(status,',')) = 1 THEN status
	WHEN cardinality(string_to_array(status,',')) = 2 AND status NOT like  '%Error%' THEN 'Running'
	WHEN cardinality(string_to_array(status,',')) = 2 AND status like '%Error%' THEN 'Error'
END
FROM cte;

--solution 2
WITH cte AS (
  SELECT 
    workflow,
    CAST(STRING_AGG(distinct RunStatus, ',') AS VARCHAR(1000)) AS status,
	COUNT(distinct RunStatus)
  FROM ProcessLog
  GROUP BY workflow
)

SELECT workflow,
CASE
WHEN count=1 THEN status
WHEN Status LIKE '%Error%' THEN 'Indeterminate'
WHEN Status LIKE '%Running%' THEN 'Running'
END

FROM cte;
