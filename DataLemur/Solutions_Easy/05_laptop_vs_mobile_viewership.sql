SELECT 
  SUM(CASE 
    WHEN device_type in ('tablet','phone') THEN 0
    ELSE 1
  END ) AS laptop_views,
  SUM(CASE 
    WHEN device_type in ('tablet','phone') THEN 1
    ELSE 0
  END ) AS mobile_views
FROM viewership