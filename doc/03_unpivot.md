Unpivot with Postgres
create table customer_turnover
(
customer_id integer,
q1 integer,
q2 integer,
q3 integer,
q4 integer
);

customer_id | q1 | q2 | q3 | q4
------------+-----+-----+-----+----
1 | 100 | 210 | 203 | 304
2 | 150 | 118 | 422 | 257
3 | 220 | 311 | 271 | 269

select c.customer_id, t.\*
from customer_turnover c
cross join lateral (
values
(c.q1, 'Q1'),
(c.q2, 'Q2'),
(c.q3, 'Q3'),
(c.q4, 'Q4')
) as t(turnover, quarter)
order by customer_id, quarter;

customer_id | turnover | quarter
------------+----------+--------
1 | 100 | Q1  
 1 | 210 | Q2  
 1 | 203 | Q3  
 1 | 304 | Q4  
 2 | 150 | Q1  
 2 | 118 | Q2  
 2 | 422 | Q3  
 2 | 257 | Q4  
 3 | 220 | Q1  
 3 | 311 | Q2  
 3 | 271 | Q3  
 3 | 269 | Q4
