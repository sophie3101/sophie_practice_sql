Calculate the friend acceptance rate for each date when friend requests were sent. A request is sent if action = sent and accepted if action = accepted. If a request is not accepted, there is no record of it being accepted in the table. The output will only include dates where requests were sent and at least one of them was accepted, as the acceptance rate can only be calculated for those dates. Show the results ordered from the earliest to the latest date.


```
select f1.date, ROUND(1.0 * COUNT(f2.user_id_receiver) / COUNT(f1.user_id_sender),2)
from fb_friend_requests f1
LEFT JOIN fb_friend_requests f2
ON f1.user_id_sender = f2.user_id_sender AND f1.user_id_receiver = f2.user_id_receiver
AND f2.action='accepted'
WHERE f1.action='sent'
GROUP BY f1.date
```
