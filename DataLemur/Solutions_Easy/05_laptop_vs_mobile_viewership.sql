-- Calculate total viewership time for:
--   - Laptops (as laptop_views)
--   - Mobile devices (tablet + phone) as mobile_views

-- Table: viewership
-- Columns:
--   user_id      INTEGER
--   device_type  STRING ('laptop', 'tablet', 'phone')
--   view_time    TIMESTAMP
-- Example Output:
-- | laptop_views | mobile_views |
-- |--------------|--------------|
-- | 2            | 3            |

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

--Solution2
SELECT 
  COUNT(*) FILTER (WHERE device_type = 'laptop') AS laptop_views,
  COUNT(*) FILTER (WHERE device_type IN ('tablet', 'phone'))  AS mobile_views 
FROM viewership;