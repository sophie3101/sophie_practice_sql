-- Problem:
-- Calculate the activation rate of users from the emails table.
-- Activation means the user has at least one 'Confirmed' record in the texts table for their email_id.
-- Activation rate = (Number of users with 'Confirmed' texts) / (Total users in emails table)
-- Round the result to 2 decimal places.
-- Notes:
-- - Only users in the emails table are considered.
-- - Some users in emails may not have any corresponding texts records.
-- - A user can have multiple texts; count them as activated if any one is 'Confirmed'.
-- - Activation rate should be returned as a decimal between 0 and 1 (e.g., 0.67).

-- Tables:
-- emails(email_id, user_id, signup_date)
-- texts(text_id, email_id, signup_action)

-- Steps:
-- 1. Join emails to texts on email_id.
-- 2. Check if 'Confirmed' exists for each email_id.
-- 3. Count total emails (users) and count of emails with confirmation.
-- 4. Calculate confirmed / total and round to 2 decimals.

SELECT ROUND(CAST(COUNT(texts.email_id) AS DECIMAL)/COUNT(emails.email_id)*1.0,2) as activation_rate
FROM emails 
LEFT JOIN texts ON emails.email_id = texts.email_id AND texts.signup_action = 'Confirmed';  