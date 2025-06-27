-- Problem:
-- UnitedHealth Group (UHG) operates a program called Advocate4Me, which allows policy holders
-- to receive support across various healthcare needs such as claims, benefits, drug coverage,
-- authorizations, emergency assistance, and portal services.

-- Task:
-- Identify how many unique policy holders have made three or more calls.
-- Each call is uniquely identified by the `case_id` field.
-- Return a single value representing the count of such policy holders.

-- Table: callers

-- Schema:
-- | Column Name        | Type      | Description                                         |
-- |--------------------|-----------|-----------------------------------------------------|
-- | policy_holder_id   | integer   | Unique identifier for the policy holder             |
-- | case_id            | varchar   | Unique identifier for each call case                |
-- | call_category      | varchar   | Category of the support call                        |
-- | call_date          | timestamp | Date and time the call was made                     |
-- | call_duration_secs | integer   | Duration of the call in seconds                     |

-- Example Input:
-- | policy_holder_id | case_id                                | call_category         | call_date                | call_duration_secs |
-- |------------------|----------------------------------------|-----------------------|--------------------------|--------------------|
-- | 1                | f1d012f9-9d02-4966-a968-bf6c5bc9a9fe     | emergency assistance  | 2023-04-13T19:16:53Z     | 144                |
-- | 1                | 41ce8fb6-1ddd-4f50-ac31-07bfcce6aaab     | authorisation         | 2023-05-25T09:09:30Z     | 815                |
-- | 2                | 9b1af84b-eedb-4c21-9730-6f099cc2cc5e     | claims assistance     | 2023-01-26T01:21:27Z     | 992                |
-- | 2                | 8471a3d4-6fc7-4bb2-9fc7-4583e3638a9e     | emergency assistance  | 2023-03-09T10:58:54Z     | 128                |
-- | 2                | 38208fae-bad0-49bf-99aa-7842ba2e37bc     | benefits              | 2023-06-05T07:35:43Z     | 619                |

-- Example Output:
-- | policy_holder_count |
-- |---------------------|
-- | 1                   |

-- Explanation:
-- In the example, policy holder with ID 2 made 3 calls, meeting the threshold.
-- Therefore, the output count of policy holders who made 3 or more calls is 1.

SELECT COUNT(*)
FROM 
(
  SELECT policy_holder_id, COUNT(case_id)
  FROM callers
  GROUP BY policy_holder_id
  HAVING COUNT(case_id) >=3) AS TEMP