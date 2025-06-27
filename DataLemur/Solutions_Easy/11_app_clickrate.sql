-- Problem:
-- Assume you have an events table for Facebook app analytics.
-- Write a query to calculate the click-through rate (CTR) for each app in the year 2022.
-- Round the CTR to 2 decimal places.

-- Definition:
-- Click-through rate (CTR) = 100.0 * Number of clicks / Number of impressions
-- Note: To avoid integer division, multiply by 100.0 (not 100).

-- Table: events

-- Schema:
-- | Column Name | Type     |
-- |-------------|----------|
-- | app_id      | integer  |
-- | event_type  | string   | -- Values include 'click' and 'impression'
-- | timestamp   | datetime |

-- Example Input:
-- | app_id | event_type | timestamp           |
-- |--------|------------|---------------------|
-- | 123    | impression | 07/18/2022 11:36:12 |
-- | 123    | impression | 07/18/2022 11:37:12 |
-- | 123    | click      | 07/18/2022 11:37:42 |
-- | 234    | impression | 07/18/2022 14:15:12 |
-- | 234    | click      | 07/18/2022 14:16:12 |

-- Example Output:
-- | app_id | ctr   |
-- |--------|-------|
-- | 123    | 50.00 |
-- | 234    | 100.00 |

SELECT app_id,
  ROUND(100.0 *
    SUM(1) FILTER (WHERE event_type = 'click') /
    SUM(1) FILTER (WHERE event_type = 'impression'), 2) AS ctr_app
FROM events
WHERE EXTRACT(YEAR FROM timestamp)=2022
GROUP BY app_id 
