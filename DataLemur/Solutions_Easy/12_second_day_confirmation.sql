SELECT user_id
FROM emails
JOIN texts ON texts.email_id = emails.email_id
WHERE signup_action='Confirmed' AND signup_date + INTERVAL '1day'=action_date