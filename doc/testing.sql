BEGIN;

UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;

-- Safter rollback, data is removed from memory
ROLLBACK;

--RAISE NOTICE: similar to print() to console, does not rollback
--RAISE EXCEPZTION: 


-- Now test a negative case inside a savepoint
    SAVEPOINT sp_test_null_violation;
    BEGIN
        -- This will fail (NULL in NOT NULL column)
        INSERT INTO funding_type(funding_type) VALUES (NULL);
    EXCEPTION WHEN not_null_violation THEN
        RAISE NOTICE 'Not null violation caught';
        ROLLBACK TO SAVEPOINT sp_test_null_violation;  -- rollback just this insert
    END;

-- exception type
unique_violation	Violation of unique constraint	23505
foreign_key_violation	Violation of foreign key constraint	23503
check_violation	Violation of check constraint	23514
not_null_violation	Attempt to insert NULL into a NOT NULL column	23502
exclusion_violation	Violation of exclusion constraint	23P01
invalid_text_representation	Invalid input syntax for type text	22P02
numeric_value_out_of_range	Numeric value out of allowed range	22003
division_by_zero	Division by zero error	22012
string_data_right_truncation	String data too long for column	22001
deadlock_detected	Deadlock detected	40P01
serialization_failure	Transaction serialization failure (e.g. in serializable isolation)	40001
insufficient_privilege	Permission denied	42501
syntax_error	SQL syntax error	42601
connection_exception	Connection failure	08000
raise_exception	Explicit RAISE from PL/pgSQL	P0001


pgtap is the testing framework, pg_prove is the test runner

pg_prove?
A command-line tool that runs your pgTAP SQL test files.

It formats the results in a nice readable way using TAP (Test Anything Protocol).

List of Assertion functions
The following table lists a few more widely used assertion functions.

PGTAP Function	Description
has_table and hasnt_table	Checks whether the specified table exists.
has_view	Checks whether the specified view exists.
has_materialized_view	Checks whether the specified materialized view exists.
has_index	Checks whether a table has the specified index.
has_relation	Checks whether the specified relation exists, which can be a table, index, or sequence.
function_returns	Checks whether a particular function returns a particular data type.
is_definer	Checks whether a function is a security definer.
col_is_pk	Checks whether a column is a primary key column of a table.
col_isnt_pk	Checks whether a column is not a primary key of a table.
col_isnt_fk	Checks whether a column is not a foreign key of a table.
has_column	Checks whether a table contains a column.
hasnt_column	Checks whether a table does not contain a column.
policy_cmd_is	Checks whether the specified row-level security policy exists.
policy_roles_are	Checks whether the row-level security policy applies to all users. The function returns TRUE if all users to which the row-level security policy applies are specified.
policies_are	Checks whether a table contains a row-level security policy.

SELECT ok(condition, 'description')
SELECT cmp_ok(left_expr, operator, right_expr, 'description')
SELECT cmp_ok(
    (SELECT COUNT(*) FROM company),
    '>=',
    1,
    'At least one company exists'
);

use () when to use expression
$$ $$ when to represent SQL code like insert statement