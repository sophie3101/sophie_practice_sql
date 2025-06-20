SELECT COUNT(merchant_id) FROM 
(SELECT t1.merchant_id, COUNT(t1.transaction_id)
FROM transactions AS t1 
JOIN transactions AS t2 ON t1.merchant_id  t2.merchant_id 
WHERE EXTRACT(EPOCH FROM t2.transaction_timestamp - t1.transaction_timestamp)/60 <=10 
  AND t1.transaction_id <> t2.transaction_id
GROUP BY t1.merchant_id
HAVING COUNT(t1.transaction_id)>1) AS temp 