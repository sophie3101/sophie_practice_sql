SELECT unique_queries, COUNT(*) AS employee_count
FROM (SELECT employees.employee_id, 
      SUM( CASE WHEN query_id IS NULL THEN 0 ELSE 1 END ) AS unique_queries
FROM queries 
RIGHT JOIN employees ON employees.employee_id = queries.employee_id 
        AND EXTRACT(MONTH FROM query_starttime) BETWEEN 7 AND 9
GROUP BY employees.employee_id) AS TEMP
GROUP BY unique_queries
ORDER BY unique_queries