Find employees who are earning more than their managers. Output the employee's first name along with the corresponding salary.
https://platform.stratascratch.com/coding/9894-employee-and-manager-salaries?code_type=1

SOLUTION
```
select e.first_name, e.salary
from employee e
JOIN employee m 
    ON e.manager_id = m.id
WHERE e.salary > m.salary

```