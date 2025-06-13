SELECT e.employee_id, e.name 
FROM employee AS e
JOIN employee AS e2 ON e.manager_id = e2.employee_id
WHERE e2.salary < e.salary