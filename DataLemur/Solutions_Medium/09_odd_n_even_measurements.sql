WITH cte AS (
  SELECT *, 
    DATE_TRUNC('day', measurement_time) AS measurement_day,
    ROW_NUMBER() OVER (
      PARTITION BY DATE_TRUNC('day', measurement_time) 
      ORDER BY DATE_TRUNC('minute', measurement_time)
    ) AS row_num
  FROM measurements
)

SELECT 
  measurement_day,
  SUM(measurement_value) FILTER (WHERE row_num % 2 = 0) AS even_sum,
  SUM(measurement_value) FILTER (WHERE row_num % 2 = 1) AS odd_sum
FROM cte
GROUP BY measurement_day;
