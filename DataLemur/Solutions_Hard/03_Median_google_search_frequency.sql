/*
Google's marketing team is making a Superbowl commercial and needs a simple
statistic to include in the TV ad: the median number of searches a person made last year.

Due to the scale of data (over 2 trillion searches), querying raw logs is too costly.
Instead, you have access to a summary table that aggregates how many users made
a given number of searches.

Your task is to write a query to calculate the **median** number of searches made by a user.
The result should be rounded to **one decimal place**.

Table: search_frequency

Columns:
- searches (integer): The number of searches made by a user in the last year
- num_users (integer): How many users made exactly that number of searches

Example Input:
searches | num_users
---------|----------
1        | 2
2        | 2
3        | 3
4        | 1

Expected Output:
median
------
2.5

Explanation:
- The full expanded list of user searches would be:
  [1, 1, 2, 2, 3, 3, 3, 4]
- There are 8 users in total (even count), so the median is the average of the 4th and 5th values: (2 + 3) / 2 = 2.5
*/

WITH cte AS (
SELECT searches
  FROM search_frequency
  GROUP BY searches, GENERATE_SERIES(1, num_users) ORDER BY searches
)

SELECT PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY searches) AS median
FROM cte 