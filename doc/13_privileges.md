When an object is created, it is assigned an owner. The owner is normally the role that executed the
creation statement

An object can be assigned to a new owner with an ALTER command of the appropriate kind for the
object, for example
ALTER TABLE table_name OWNER TO new_owner;

To assign privileges, the GRANT command is used. For example, if joe is an existing role, and
accounts is an existing table, the privilege to update the table can be granted with:

GRANT UPDATE ON accounts TO joe;
GRANT SELECT ON employees TO PUBLIC; --Then anyone can do:SELECT * FROM employees;

-- to check who has select access afterward
SELECT grantee, privilege_type
FROM information_schema.role_table_grants
WHERE table_name = 'your_table_name';

--removes all privileges (like SELECT, INSERT, UPDATE, etc.) on the accounts table from all users who are part of the special PUBLIC group.
REVOKE ALL ON accounts FROM PUBLIC;
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM PUBLIC;
to prevent database users from creating objects in the public schema, do the following:
postgres=> REVOKE CREATE ON SCHEMA public FROM PUBLIC;


PostgreSQL uses the concept of roles to represent user accounts. It doesn’t use the concept of users like other database systems.
to create role: `CREATE ROLE role_name;`

`CREATE ROLE name WITH option;`

e.g:
--create role with login privilege s
CREATE ROLE alice
LOGIN
PASSWORD 'securePass1';
-- to alter: ALTER ROLE <> WITH LOGIN;
CREATE ROLE john
SUPERUSER
LOGIN
PASSWORD 'securePass1';

special “role” name PUBLIC can be used to grant a privilege to every role on the system.

\dp <table name> to view priviledges of the table
If the “Access privileges” column is empty for a given object, it means the object has default privileges

 By default, tables do not have any policies

CREATE TABLE accounts (manager text, company text, contact_email
text);
ALTER TABLE accounts ENABLE ROW LEVEL SECURITY;
CREATE POLICY account_managers ON accounts TO managers
USING (manager = current_user);

GRANT controls what a user can do (read, write, etc.) at the table level.Row-Level Security (RLS) controls which rows a user can see or modify within a table.