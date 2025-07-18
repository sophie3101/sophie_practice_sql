resources:
https://www.databasestar.com/sql-constraints/#constraint-states-validate-vs-novalidate

constraint is a rule that you define on a table that restricts the values in that table. \
They can be added to a table or a view when you create it, or after it's created\
To create contstrain: 
- When the table is created, as part of the CREATE TABLE (or CREATE VIEW) statement:
    - Inline: next to the name of the column
    - Out of line: at the end of the CREATE statement
- After the table is created, as part of the ALTER TABLE (or ALTER VIEW) statementL
    ```ALTER TABLE employee
    ADD CONSTRAINT pk_emp_id PRIMARY KEY(employee_id);```
# Types of Constraints:
1. Primary Key Constraint: this ensures all rows have a unique value and cannot be NULL, often used as an identifier of a table's row. 

    ```CONSTRAINT constraint_name PRIMARY KEY constraint_parameters```
e.g:
```
--inline
CREATE TABLE employee (
  employee_id NUMBER(10) CONSTRAINT pk_emp_id PRIMARY KEY,
  first_name VARCHAR2(200),
  last_name VARCHAR2(200),
  salary NUMBER(10),
  hire_date DATE
);
--composite primary key
CREATE TABLE employee (
  employee_id NUMBER(10),
  first_name VARCHAR2(200),
  last_name VARCHAR2(200),
  salary NUMBER(10),
  hire_date DATE,
  CONSTRAINT pk_emp_flname PRIMARY KEY (first_name, last_name)
);

-- or out of line
CREATE TABLE employee (
  employee_id NUMBER(10),
  first_name VARCHAR2(200),
  last_name VARCHAR2(200),
  salary NUMBER(10),
  hire_date DATE,
  CONSTRAINT pk_emp_id PRIMARY KEY (employee_id)
);

--
ALTER TABLE employee
ADD CONSTRAINT pk_emp_id PRIMARY KEY(employee_id);

```
2. Foreign Key Constraint: this ensures that values in a column (or several columns) match values in another table's column/s. It allows you to enforce referential integrity, which means that a record in one table relates to a record in another table.\
```CONSTRAINT constraint_name REFERENCES constraint_parameters```
    - ON DELETE SET NULL: When you delete the parent record, then all child records will have the referenced column set to NULL.
    - ON DELETE CASCADE: When you delete the parent record, then all child records will be deleted as well.

e:g
```
--inline
CREATE TABLE employee (
  employee_id NUMBER(10),
  first_name VARCHAR2(200),
  last_name VARCHAR2(200),
  salary NUMBER(10),
  hire_date DATE,
  department_id NUMBER(10) CONSTRAINT fk_emp_deptid
  REFERENCES department(dept_id)
);

--out of line
CREATE TABLE employee (
  employee_id NUMBER(10),
  first_name VARCHAR2(200),
  last_name VARCHAR2(200),
  salary NUMBER(10),
  hire_date DATE,
  department_id NUMBER(10),
  CONSTRAINT fk_emp_deptid
  FOREIGN KEY (department_id)
  REFERENCES department(dept_id)
  ON DELETE SET NULL
);
-- the employees with the deleted department_id will have the department_id set to NULL.

--alter table
ALTER TABLE employee
ADD CONSTRAINT fk_emp_deptid
FOREIGN KEY (department_id)
REFERENCES department(dept_id);
```
3. Unique Constraint: this ensures all rows have a unique value. \
```CONSTRAINT constraint_name UNIQUE (columns)```

```
--inline
CREATE TABLE employee (
  employee_id NUMBER(10),
  first_name VARCHAR2(200),
  last_name VARCHAR2(200),
  government_id VARCHAR(20) UNIQUE,
  salary NUMBER(10),
  hire_date DATE,
  department_id NUMBER(10)
);
--out of line
CREATE TABLE employee (
  employee_id NUMBER(10),
  first_name VARCHAR2(200),
  last_name VARCHAR2(200),
  government_id VARCHAR(20),
  salary NUMBER(10),
  hire_date DATE,
  department_id NUMBER(10),
  CONSTRAINT uc_emp_govtid UNIQUE (government_id)
);
--
ALTER TABLE employee
ADD CONSTRAINT uc_emp_govtid UNIQUE (government_id);
```
4. Not Null Constraint: this ensures a value cannot be NULL.
5. Check Constraint: this ensures a value meets a specific condition. \
```CONSTRAINT constraint_name CHECK (conditions)```

e.g 
```
CREATE TABLE employee (
  employee_id NUMBER(10),
  first_name VARCHAR2(200),
  last_name VARCHAR2(200),
  government_id VARCHAR(20),
  salary NUMBER(10) CONSTRAINT ck_emp_salary
  CHECK (salary BETWEEN 10000 AND 500000),
  hire_date DATE,
  department_id NUMBER(10)

  CREATE TABLE employee (
  employee_id NUMBER(10),
  first_name VARCHAR2(200),
  last_name VARCHAR2(200),
  government_id VARCHAR(20),
  salary NUMBER(10),
  hire_date DATE,
  department_id NUMBER(10),
  CONSTRAINT ck_emp_salary
  CHECK (salary BETWEEN 10000 AND 500000)
);
ALTER TABLE employee
ADD CONSTRAINT ck_emp_govtid
CHECK (LENGTH(government_id) > 3);
```

# Constaint States
With all of the constraints we create, there are several keywords used to put the constraints into several different states.

These keywords are:

DEFERRABLE \
NOT DEFERRABLE \
INITIALLY IMMEDIATE: means the constraint is checked at the end of each statement. This is the default.\
INITIALLY DEFERRED: means that the constraint is checked at the end of each subsequent transaction.\
ENABLE\
DISABLE\
VALIDATE\
NOVALIDATE


DEFERRABLE and NOT DEFERRABLE, determine if checking for constraints in future transactions can be deferred until the end of the transaction. You can't change the deferrability of a constraint. This means if you create it as DEFERRABLE then you can't alter it to be NOT DEFERRABLE, and vice versa. You need to drop the constraint and create it again.

Enabled constraints are “turned on” and are applied to the data in the table. Disabled constraints are not applied to the data in the table, but appear in the data dictionary and still exist.

The enabled and disabled states of a constraint can be changed by using ENABLE and DISABLE. The default is ENABLE.
The behaviour of VALIDATE and NOVALIDATE depends on if the constraint is ENABLED or DISABLED.

To find details about the constraints, you can query the USER_CONSTRAINTS view.

```SELECT *
FROM user_constraints;
```