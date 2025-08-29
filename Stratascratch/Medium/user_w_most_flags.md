https://platform.stratascratch.com/coding/2104-user-with-most-approved-flags?code_type=1

Which user flagged the most distinct videos that ended up approved by YouTube? Output, in one column, their full name or names in case of a tie. In the user's full name, include a space between the first and the last name.

```
WITH cte AS 
(
    select CONCAT_WS(' ', user_firstname, user_lastname) AS username, 
    COUNT(distinct video_id) AS video_count,
    RANK()OVER(ORDER BY COUNT(distinct video_id) DESC) as rnk
    from user_flags 
    WHERE EXISTS(
        SELECT 1
        FROM flag_review
        WHERE user_flags.flag_id=flag_review.flag_id
        AND reviewed_outcome='APPROVED')
    GROUP BY user_firstname, user_lastname
    ORDER BY video_count DESC
)

SELECT username 
FROM cte
WHERE rnk =1

```