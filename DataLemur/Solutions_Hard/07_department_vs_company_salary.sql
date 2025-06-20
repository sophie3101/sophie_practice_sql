SELECT DISTINCT department_id,
       TO_CHAR(payment_date,'MM-YYYY'),
       CASE WHEN AVG(amount) OVER (PARTITION BY department_id) < AVG(amount) OVER ()
            THEN 'lower'
            WHEN AVG(amount) OVER (PARTITION BY department_id) = AVG(amount) OVER ()
            THEN 'same'
            WHEN AVG(amount) OVER (PARTITION BY department_id) > AVG(amount) OVER ()
            THEN 'higher' END
FROM employee AS emp
INNER JOIN salary AS s
ON emp.employee_id = s.employee_id
WHERE EXTRACT(MONTH FROM payment_date) = 3
      AND EXTRACT(YEAR FROM payment_date) = 2024;


-- DataLemur solution
WITH company_avg AS ( -- CTE from Step 1
  SELECT 
    payment_date,
    AVG(amount) AS co_avg_salary
  FROM salary
  WHERE payment_date = '03/31/2024 00:00:00'
  GROUP BY payment_date
)
, dept_avg AS ( -- CTE from Step 2
  SELECT
    e.department_id,
    s.payment_date,
    AVG(s.amount) AS dept_avg_salary
  FROM salary AS s
  INNER JOIN employee AS e
    ON s.employee_id = e.employee_id
  WHERE s.payment_date = '03/31/2024 00:00:00'
  GROUP BY e.department_id, s.payment_date
)

SELECT
  d.department_id,
  TO_CHAR(d.payment_date, 'MM-YYYY') AS payment_date,
  CASE  
    WHEN d.dept_avg_salary > c.co_avg_salary THEN 'higher'
    WHEN d.dept_avg_salary < c.co_avg_salary THEN 'lower'
    ELSE 'same'
  END AS comparison
FROM dept_avg AS d
INNER JOIN company_avg AS c
  ON d.payment_date = c.payment_date;