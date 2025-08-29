
https://platform.stratascratch.com/coding/10159-ranking-most-active-guests?code_type=1
Identify the most engaged guests by ranking them according to their overall messaging activity. The most active guest, meaning the one who has exchanged the most messages with hosts, should have the highest rank. If two or more guests have the same number of messages, they should have the same rank. Importantly, the ranking shouldn't skip any numbers, even if many guests share the same rank. Present your results in a clear format, showing the rank, guest identifier, and total number of messages for each guest, ordered from the most to least active.
```select id_guest, 
SUM(n_messages),
DENSE_RANK()OVER(ORDER BY SUM(n_messages) DESC)
from airbnb_contacts
GROUP BY id_guest
```