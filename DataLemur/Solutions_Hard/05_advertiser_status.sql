SELECT COALESCE(advertiser.user_id, daily_pay.user_id) AS user_id,
CASE 
  WHEN paid is NOT NULL AND advertiser.status IN ('NEW', 'EXISTING','RESURRECT') THEN 'EXISTING'
  WHEN  paid is NULL THEN 'CHURN'
  WHEN advertiser.status ='CHURN' AND paid is NOT NULL THEN 'RESURRECT'
  WHEN advertiser.status IS NULL AND paid is NOT NULL THEN 'NEW'
  ELSE advertiser.status
END AS new_status
FROM advertiser
FULL OUTER JOIN daily_pay ON advertiser.user_id = daily_pay.user_id
ORDER BY user_id