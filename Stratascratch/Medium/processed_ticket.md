https://platform.stratascratch.com/coding/9781-find-the-rate-of-processed-tickets-for-each-type?code_type=1
Find the processed rate of tickets for each type. The processed rate is defined as the number of processed tickets divided by the total number of tickets for that type. Round this result to two decimal places.

Table
facebook_complaints

```select type,
ROUND(1.0 * COUNT(*)FILTER(WHERE processed=TRUE)/COUNT(*),2) AS processed_rate
from facebook_complaints
GROUP BY type
```