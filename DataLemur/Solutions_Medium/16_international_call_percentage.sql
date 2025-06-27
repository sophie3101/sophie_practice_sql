-- A phone call is considered an international call when the person calling 
-- is in a different country than the person receiving the call.

-- Objective:
-- Calculate the percentage of phone calls that are international.
-- Round the result to 1 decimal place.

-- Assumption:
-- The caller_id in the phone_info table refers to both the caller and the receiver.

-- Tables:

-- phone_calls Table:
-- Column Name     Type
-- caller_id       integer
-- receiver_id     integer
-- call_time       timestamp

-- Example Input (phone_calls):
-- caller_id   receiver_id   call_time
-- 1           2             2022-07-04 10:13:49
-- 1           5             2022-08-21 23:54:56
-- 5           1             2022-05-13 17:24:06
-- 5           6             2022-03-18 12:11:49

-- phone_info Table:
-- Column Name     Type
-- caller_id       integer
-- country_id      text
-- network         text
-- phone_number    string

-- Example Input (phone_info):
-- caller_id   country_id   network    phone_number
-- 1           US           Verizon    +1-212-897-1964
-- 2           US           Verizon    +1-703-346-9529
-- 3           US           Verizon    +1-650-828-4774
-- 4           US           Verizon    +1-415-224-6663
-- 5           IN           Vodafone   +91 7503-907302
-- 6           IN           Vodafone   +91 2287-664895

-- Expected Output:
-- international_calls_pct
-- 50.0

SELECT 
ROUND(
  CAST(COUNT(*) FILTER(WHERE caller_info.country_id <> receiver_info.country_id) AS DECIMAL) /COUNT(*) * 100
,1)
FROM phone_calls call
LEFT JOIN phone_info AS caller_info ON caller_info.caller_id=call.caller_id 
LEFT JOIN phone_info  AS receiver_info ON call.receiver_id = receiver_info.caller_id
