\unset ECHO 
\set QUIET 1 
\set ON_ERROR_ROLLBACK 1 
\set ON_ERROR_STOP true 

BEGIN; 
SELECT plan(19);

-- users related table existence
SELECT has_table('users', 'Table users exists');
SELECT has_table('roles', 'Table roles exists');
SELECT has_table('user_roles', 'Table user_roles exists');
--
CALL user_permissions_procedure(current_database()::VARCHAR, 'test');
INSERT INTO users (username, email, password_hash) VALUES
  ('userA', 'usera@example.com', 'hashed_password_1'),
  ('userB', 'userb@example.com', 'hashed_password_2');
INSERT INTO roles (role_name, role_description) VALUES
  ('admin', 'Administrator role with full access'),
  ('normal_user', 'Standard user role'),
  ('guest', 'Limited access role');
INSERT INTO user_roles (user_id, role_id) VALUES
  (1, 1),(1, 2),(2, 2); 


--test role creation
SELECT has_role('admin', 'admin role exists');
SELECT has_role('normal_user', 'Check if normal_user role exists');
SELECT has_role('guest', 'Check if guest role exists');

-- test database connection
SELECT ok(
  (SELECT has_database_privilege('admin', current_database(), 'CONNECT')),
  format('Admin has CONNECT privilege on database %s', current_database())
);
SELECT ok(
  (SELECT not has_database_privilege('admin', 'postgres', 'CONNECT')),
  format('Admin does not have CONNECT privilege on database %s', 'postgres')
);
SELECT ok(
  (SELECT has_database_privilege('normal_user', current_database(), 'CONNECT')),
  format('normal_user have CONNECT privilege on database %I', current_database())
);
SELECT ok(
  (SELECT not has_database_privilege('normal_user', 'postgres', 'CONNECT')),
  format('normal_user does have CONNECT privilege on database %I', 'postgres')
);
SELECT ok(
  (SELECT has_database_privilege('guest', current_database(), 'CONNECT')),
  format('guest have CONNECT privilege on database %I', current_database())
);
SELECT ok(
  (SELECT not has_database_privilege('guest', 'postgres', 'CONNECT')),
  format('guest does not have CONNECT privilege on database %I', 'postgres')
);
-- test schema priveledge
SELECT ok (
  (SELECT has_schema_privilege('admin', 'test', 'USAGE')),
  format('admin has  USAGE priviledge on schema %s', 'test')
);
SELECT ok (
  (SELECT has_schema_privilege('guest', 'test', 'USAGE')),
  format('guest has  USAGE priviledge on schema %s', 'test')
);
SELECT ok (
  (SELECT not has_schema_privilege('guest', 'public', 'USAGE')),
  format('guest does not have  USAGE priviledge on schema %s', 'public')
);

CREATE TABLE test_table(id SERIAL PRIMARY KEY, input TEXT);
CREATE FUNCTION test_function() RETURNS TEXT AS $$ SELECT 'test'; $$ LANGUAGE SQL;
SELECT ok(
  (SELECT has_table_privilege('admin', 'test_table', 'SELECT,INSERT,UPDATE,DELETE')),
  format('admin has all priviledges to table %s', 'test_table')
);
SELECT ok(
  (SELECT has_table_privilege('normal_user', 'test_table', 'SELECT,INSERT,UPDATE,DELETE')),
  format('normal_user has all priviledges to table %s', 'test_table')
);
SELECT ok(
  (SELECT not has_table_privilege('guest', 'test_table', 'SELECT')),
  format('guest does not have priviledges to table %s', 'test_table')
);

SELECT ok(
    (SELECT has_function_privilege('admin', 'test_function()', 'EXECUTE')),
    'Admin should have EXECUTE privilege on test_function'
);


-- #################################################
--  Finish tests and clean up
-- #################################################
SELECT * FROM finish();

ROLLBACK;