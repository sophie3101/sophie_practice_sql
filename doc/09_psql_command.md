1. connect to datbase
list all commands: `\?`

2. switch to another database: `\c <databasename> `

3. list available dtabase: `\l`

4. list tables: `\dt`

    desribe table `\d table_name`

5. list schema `\dn`

6. list function: `\df`

7. list vies: `\dv`

8. list user: `\du`; view more in `pg_roles`

9. comamnd history: `\s`

10. execute commands from a file: `\i filename `

11. turn on query execution time: `\timing`

`pg_database` contains all database names, `SELECT datname FROM pg_database;`
each database contains `pg_catalog` schema: contains system tables, functions, operators

PostgreSQL comes with two default tablespaces:

pg_default tablespace stores user data.
pg_global tablespace stores global data.

`information_schema.columns` catalog contains information on columns of all tables;