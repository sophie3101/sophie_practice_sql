/*
You're provided with two tables:

1. `advertiser`: Contains information about Facebook advertisers and their current payment status.
2. `daily_pay`: Contains payment records for advertisers who have made a payment on a specific day.
   Note: `daily_pay` only includes users who made payments (i.e., no entry = no payment).

Your task:
Write a query to update the payment status of each advertiser based on whether or not they made
a payment on the current day (T), as indicated by the `daily_pay` table.

The output should:
- Include the `user_id` and their new payment status (`new_status`)
- Be sorted by `user_id`

---

Payment Status Transitions:

Advertiser status is updated based on the following rules:

| Previous Status | Made Payment Today? | Updated Status |
|------------------|---------------------|----------------|
| NEW              | Yes                 | EXISTING       |
| NEW              | No                  | CHURN          |
| EXISTING         | Yes                 | EXISTING       |
| EXISTING         | No                  | CHURN          |
| CHURN            | Yes                 | RESURRECT      |
| CHURN            | No                  | CHURN          |
| RESURRECT        | Yes                 | EXISTING       |
| RESURRECT        | No                  | CHURN          |

Rule summary:
- If a user *did not pay* today (not in `daily_pay`), their status becomes `CHURN`.
- If a user *did pay* today:
  - If their current status is `CHURN`, they become `RESURRECT`.
  - Otherwise, they become `EXISTING`.

---

Table: advertiser

| Column   | Type   |
|----------|--------|
| user_id  | string |
| status   | string |

Example Input:
user_id | status
--------|---------
bing    | NEW
yahoo   | NEW
alibaba | EXISTING

---

Table: daily_pay

| Column   | Type    |
|----------|---------|
| user_id  | string  |
| paid     | decimal |

Example Input:
user_id | paid
--------|------
yahoo   | 45.00
alibaba | 100.00
target  | 13.00

---

Expected Output:
user_id | new_status
--------|------------
alibaba | EXISTING
bing    | CHURN
yahoo   | EXISTING

Explanation:
- "bing" is not in `daily_pay`, so becomes CHURN.
- "yahoo" paid today and was NEW → becomes EXISTING.
- "alibaba" paid today and was EXISTING → stays EXISTING.
*/

SELECT COALESCE(advertiser.user_id, daily_pay.user_id) AS user_id,
CASE 
  WHEN paid is NOT NULL AND advertiser.status IN ('NEW', 'EXISTING','RESURRECT') THEN 'EXISTING'
  WHEN  paid is NULL THEN 'CHURN'
  WHEN advertiser.status ='CHURN' AND paid is NOT NULL THEN 'RESURRECT'
  WHEN advertiser.status IS NULL AND paid is NOT NULL THEN 'NEW'
  ELSE advertiser.status
END AS new_status
FROM advertiser
FULL OUTER JOIN daily_pay ON advertiser.user_id = daily_pay.user_id
ORDER BY user_id