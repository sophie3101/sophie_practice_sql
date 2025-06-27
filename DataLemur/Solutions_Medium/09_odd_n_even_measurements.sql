/*
Problem Description:
Given a table of measurements recorded by a Google sensor over multiple days, with multiple measurements per day,
the goal is to calculate the sum of odd-numbered and even-numbered measurements separately for each day.

Definitions:
- Odd-numbered measurements: those taken 1st, 3rd, 5th, etc. times within a single day.
- Even-numbered measurements: those taken 2nd, 4th, 6th, etc. times within a single day.

Requirements:
- For each day, compute the sum of odd and even measurements.
- Display the sums in separate columns.
- Output the date as measurement_day.
- Round sums to 2 decimal places (if applicable).
- Order results by measurement_day.

Data:
Table: measurements
Columns:
- measurement_id (integer)
- measurement_value (decimal)
- measurement_time (datetime)

Example Input:
measurement_id | measurement_value | measurement_time
------------------------------------------------------
131233         | 1109.51           | 07/10/2022 09:00:00
135211         | 1662.74           | 07/10/2022 11:00:00
523542         | 1246.24           | 07/10/2022 13:15:00
143562         | 1124.50           | 07/11/2022 15:00:00
346462         | 1234.14           | 07/11/2022 16:45:00

Expected Output:
measurement_day    | odd_sum | even_sum
-----------------------------------------
07/10/2022 00:00:00| 2355.75 | 1662.74
07/11/2022 00:00:00| 1124.50 | 1234.14
*/

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
