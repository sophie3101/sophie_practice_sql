SELECT age_bucket,
ROUND(100.0* SUM(time_spent) FILTER( WHERE activity_type='send')/SUM(time_spent), 2) AS send_perc,
ROUND(100.0* SUM(time_spent) FILTER( WHERE activity_type='open')/SUM(time_spent), 2) AS open_perc
FROM activities a 
JOIN age_breakdown b ON a.user_id = b.user_id 
WHERE activity_type in ('send', 'open')
GROUP BY age_bucket
ORDER BY age_bucket