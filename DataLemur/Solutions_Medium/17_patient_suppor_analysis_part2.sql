-- UnitedHealth Group (UHG) has a program called Advocate4Me, which allows policy holders 
-- (also referred to as members) to call an advocate and receive support for their health care needs.
-- These needs may include claims and benefits support, drug coverage, pre- and post-authorisation, 
-- medical records, emergency assistance, or member portal services.

-- Calls to the Advocate4Me call centre are categorised into different types.
-- However, some calls cannot be neatly categorised. These calls are either:
-- - labeled as “n/a”
-- - or have an empty/null value in the call_category field when the support agent does not enter a category.

-- Task:
-- Write a query to calculate the percentage of calls that cannot be categorised.
-- Round the result to 1 decimal place. 
-- For example, output like: 45.0, 48.5, 57.7

-- Table: callers
-- Column Name           Type
-- policy_holder_id      integer
-- case_id               varchar
-- call_category         varchar
-- call_date             timestamp
-- call_duration_secs    integer

-- Example Input (callers):
-- policy_holder_id   case_id                                call_category           call_date                  call_duration_secs
-- 1                  f1d012f9-9d02-4966-a968-bf6c5bc9a9fe    emergency assistance    2023-04-13T19:16:53Z       144
-- 1                  41ce8fb6-1ddd-4f50-ac31-07bfcce6aaab    authorisation           2023-05-25T09:09:30Z       815
-- 2                  9b1af84b-eedb-4c21-9730-6f099cc2cc5e    n/a                     2023-01-26T01:21:27Z       992
-- 2                  8471a3d4-6fc7-4bb2-9fc7-4583e3638a9e    emergency assistance    2023-03-09T10:58:54Z       128
-- 2                  38208fae-bad0-49bf-99aa-7842ba2e37bc    benefits                2023-06-05T07:35:43Z       619

-- Expected Output:
-- uncategorised_call_pct
-- 20.0

SELECT 

ROUND(100.0*COUNT(*)FILTER(WHERE call_category='n/a' OR call_category IS NULL)/COUNT(*),1)
FROM callers;