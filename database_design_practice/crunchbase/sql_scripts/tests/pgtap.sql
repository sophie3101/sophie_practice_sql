
\unset ECHO --disable command echoing
\set QUIET 1 -- suppress internal psql messages -- Turn off echo and keep things quiet.

-- -- Format the output for nice TAP.
-- \pset format unaligned --Sets output format to **unaligned** (plain text, no column borders or padding). 
-- \pset tuples_only true
-- \pset pager off --Disables paging of output (e.g., with `less` or `more`).  - Ensures the full test output is shown in the terminal or pipeline.

-- Revert all changes on failure.
\set ON_ERROR_ROLLBACK 1 --If an error occurs, the current transaction is rolled back, but the session continues.
\set ON_ERROR_STOP true --Ensures that critical failures stop the test file from continuing.

-- Start transaction and plan the tests.
BEGIN;
SELECT plan(14);
-- test table existence
SELECT has_table('company', 'Table company exists');
SELECT has_table('company_location', 'Table company_location exists');
SELECT has_table('company_category', 'Table company_category exists');
SELECT has_table('company_status', 'Table company_status exists');
SELECT has_table('funding_type', 'Table funding type exists');
SELECT hasnt_table('investments', 'Table investments not exists');
-- test column existence
SELECT has_column('company','company_name', 'column company_name exists');
SELECT hasnt_column('company', 'company_location', 'company should not have location');

-- test primary keys, foreign keys
SELECT col_is_pk('company', 'company_id', 'company_id is primary key');
SELECT col_is_fk('company', 'location_id', 'location_id column is foreign key');

-- test insert transation
INSERT INTO company_status (status_name) VALUES ('closed');
SELECT ok(
    EXISTS (
        SELECT 1 FROM company_status WHERE status_name = 'closed'
    ),
    'status_name = ''closed'' exists in company_status'
);

-- use lives_ok: est whether a SQL statement or block runs without error. but not execute
SELECT lives_ok(
    $$INSERT INTO company_category (category_name) VALUES ('healthcare')$$,
    'should insert "healthcare" category successfully the first time'
);

-- PREPARE attempt_duplicate_insert AS
--   INSERT INTO company_category (category_name) VALUES ('healthcare');

-- SELECT throws_ok(
--   'attempt_duplicate_insert',
--   '23505',
--   'should throw unique violation error when inserting duplicate "healthcare"'
-- );

-- test the function;
DELETE FROM company_category WHERE category_name='healthcare';

SELECT lives_ok(
    $$ SELECT insert_company_category('healthcare') $$,
    'function insert_company_category is executed'
);

SELECT results_eq(
  (SELECT location_id FROM SELECT insert_company_location('USA', 'TX')),
  (SELECT location_id FROM company_location WHERE country='USA' AND ),
  'function returns expected rows'
);

-- #################################################
--  Finish tests and clean up
-- #################################################
SELECT *
FROM finish();

ROLLBACK;

