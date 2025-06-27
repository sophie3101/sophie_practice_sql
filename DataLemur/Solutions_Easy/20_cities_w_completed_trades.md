### Problem Statement

Assume you're given the tables containing completed trade orders and user details in a Robinhood trading system.

Write a query to retrieve the **top three cities** that have the **highest number of completed trade orders**, listed in **descending order**. Output the city name and the corresponding number of completed trade orders.

---

### Tables

#### `trades` Table:

| Column Name | Type                              |
| ----------- | --------------------------------- |
| order_id    | integer                           |
| user_id     | integer                           |
| quantity    | integer                           |
| status      | string ('Completed', 'Cancelled') |
| date        | timestamp                         |
| price       | decimal (5, 2)                    |

#### trades Example Input:

| order_id | user_id | quantity | status    | date                | price |
| -------- | ------- | -------- | --------- | ------------------- | ----- |
| 100101   | 111     | 10       | Cancelled | 08/17/2022 12:00:00 | 9.80  |
| 100102   | 111     | 10       | Completed | 08/17/2022 12:00:00 | 10.00 |
| 100259   | 148     | 35       | Completed | 08/25/2022 12:00:00 | 5.10  |
| 100264   | 148     | 40       | Completed | 08/26/2022 12:00:00 | 4.80  |
| 100305   | 300     | 15       | Completed | 09/05/2022 12:00:00 | 10.00 |
| 100400   | 178     | 32       | Completed | 09/17/2022 12:00:00 | 12.00 |
| 100565   | 265     | 2        | Completed | 09/27/2022 12:00:00 | 8.70  |

---

#### `users` Table:

| Column Name | Type    |
| ----------- | ------- |
| user_id     | integer |
| city        | string  |
| email       | string  |

## SOLUTION

SELECT
users.city,
COUNT(trades.order_id) AS total_orders
FROM trades
INNER JOIN users
ON trades.user_id = users.user_id
WHERE trades.status = 'Completed'
GROUP BY users.city
ORDER BY total_orders DESC
LIMIT 3;
