SELECT ROUND(CAST(COUNT(texts.email_id) AS DECIMAL)/COUNT(emails.email_id)*1.0,2) as activation_rate
FROM emails 
LEFT JOIN texts ON emails.email_id = texts.email_id AND texts.signup_action = 'Confirmed';  