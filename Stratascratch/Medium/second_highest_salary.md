https://platform.stratascratch.com/coding/9892-second-highest-salary?code_type=1
Find the second highest salary of employees.
```select MAX(salary)
from employee
WHERE salary < (SELECT MAX(salary) FROM employee)
```