https://platform.stratascratch.com/coding/10296-facebook-accounts?code_type=1
Calculate the ratio of accounts closed on January 10th, 2020 using the fb_account_status table.

```
select  
ROUND(1.0 * COUNT(*)FILTER(WHERE status<>'open')/COUNT(*),2) AS closed_ratio
from fb_account_status
WHERE DATE_TRUNC('day', status_date) = '2020-01-10'
```