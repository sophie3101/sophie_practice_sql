Turn an array into rows.
Example:
sql
Copy
Edit
SELECT unnest(ARRAY[10, 20, 30, 40]) AS value;
Result:
value
10
20
30
40
