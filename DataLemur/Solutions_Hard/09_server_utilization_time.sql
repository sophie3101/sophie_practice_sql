--mysolution
WITH cte AS (SELECT *,
  LEAD(session_status) OVER(PARTITION BY server_id ORDER BY status_time) AS next_status,
  LEAD(status_time) OVER(PARTITION BY server_id ORDER BY status_time) AS time2
FROM server_utilization 
)

SELECT 
SUM(CASE WHEN EXTRACT(DAY FROM time2-status_time)=0 THEN 1 ELSE EXTRACT(DAY FROM time2-status_time) END)
FROM cte
WHERE session_status='start' AND next_status='stop'
 

--datalemur solution
WITH running_time 
AS (
  SELECT
    server_id,
    session_status,
    status_time AS start_time,
    LEAD(status_time) OVER (
      PARTITION BY server_id
      ORDER BY status_time) AS stop_time
  FROM server_utilization
)

SELECT
  DATE_PART('days', JUSTIFY_HOURS(SUM(stop_time - start_time))) AS total_uptime_days
FROM running_time
WHERE session_status = 'start'
  AND stop_time IS NOT NULL;