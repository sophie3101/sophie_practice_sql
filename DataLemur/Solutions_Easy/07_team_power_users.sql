SELECT sender_id, COUNT(message_id)
FROM messages
WHERE EXTRACT(YEAR FROM sent_date)='2022' AND EXTRACT(MONTH FROM sent_date)='08'
GROUP BY sender_id
ORDER BY COUNT(message_id) DESC
LIMIT 2