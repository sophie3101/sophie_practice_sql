- Identify the top 2 users who sent the highest number of messages in August 2022.
-- Output their sender IDs and the total number of messages sent.
-- Results should be in descending order of message count.

-- Table: messages
-- Columns:
--   message_id   INTEGER
--   sender_id    INTEGER
--   receiver_id  INTEGER
--   content      VARCHAR
--   sent_date    DATETIME
SELECT sender_id, COUNT(message_id)
FROM messages
WHERE EXTRACT(YEAR FROM sent_date)='2022' AND EXTRACT(MONTH FROM sent_date)='08'
GROUP BY sender_id
ORDER BY COUNT(message_id) DESC
LIMIT 2