SELECT 
ROUND(
  CAST(COUNT(*) FILTER(WHERE caller_info.country_id <> receiver_info.country_id) AS DECIMAL) /COUNT(*) * 100
,1)
FROM phone_calls call
LEFT JOIN phone_info AS caller_info ON caller_info.caller_id=call.caller_id 
LEFT JOIN phone_info  AS receiver_info ON call.receiver_id = receiver_info.caller_id
