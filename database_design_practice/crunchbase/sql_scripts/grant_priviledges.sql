CREATE OR REPLACE PROCEDURE user_permissions_procedure( database_name VARCHAR, schema_name VARCHAR)
LANGUAGE plpgsql
AS $$ 
DECLARE
    db RECORD;
BEGIN

    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'admin') THEN
        CREATE ROLE admin LOGIN PASSWORD 'adminpasswd';
    END IF;

    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'normal_user') THEN
        CREATE ROLE normal_user LOGIN PASSWORD 'userpasswd';
    END IF;

    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'guest') THEN
        CREATE ROLE guest LOGIN PASSWORD 'guesspasswd';
    END IF;


   
    -- Revoke all privileges from PUBLIC
    for db IN 
        SELECT datname FROM pg_database WHERE datallowconn = true
    LOOP 
        RAISE NOTICE 'Revoke database: %', db.datname;
        EXECUTE format('REVOKE CONNECT ON DATABASE %I FROM PUBLIC', db.datname);
    END LOOP;

    EXECUTE format('REVOKE EXECUTE ON ALL FUNCTIONS IN SCHEMA %I FROM PUBLIC', schema_name);
    EXECUTE ('REVOKE ALL ON SCHEMA public FROM public');
    EXECUTE format('REVOKE ALL ON SCHEMA %I FROM public', schema_name);
    EXECUTE format('REVOKE ALL ON ALL TABLES IN SCHEMA %I FROM PUBLIC', schema_name);
    
    -- Grant database and schema permissions
    EXECUTE format('GRANT CONNECT ON DATABASE %I TO admin, normal_user, guest', database_name);
    EXECUTE format('GRANT USAGE ON SCHEMA %I TO admin, normal_user, guest', schema_name);

    -- Admin Role: Grant all privileges, existing and future
    EXECUTE format('GRANT ALL ON ALL TABLES IN SCHEMA %I TO admin', schema_name);
    EXECUTE format('GRANT ALL ON ALL SEQUENCES IN SCHEMA %I TO admin', schema_name);
    EXECUTE format('GRANT ALL ON ALL FUNCTIONS IN SCHEMA %I TO admin', schema_name);
    EXECUTE format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT ALL ON TABLES TO admin', schema_name);
    EXECUTE format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT ALL ON SEQUENCES TO admin', schema_name);
    EXECUTE format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT ALL ON FUNCTIONS TO admin', schema_name);
    RAISE NOTICE 'Granted ALL privileges to admin on existing and future objects in schema %.', schema_name;

    -- Normal User Role: Grant DML privileges
    EXECUTE format('GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA %I TO normal_user', schema_name);
    EXECUTE format('GRANT USAGE ON ALL SEQUENCES IN SCHEMA %I TO normal_user', schema_name);
    EXECUTE format('GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA %I TO normal_user', schema_name);
    EXECUTE format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO normal_user', schema_name);
    EXECUTE format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT USAGE ON SEQUENCES TO normal_user', schema_name);
    EXECUTE format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT EXECUTE ON FUNCTIONS TO normal_user', schema_name);
    RAISE NOTICE 'Granted DML and execute privileges to normal_user on existing and future objects in schema %.', schema_name;

    -- Guest Role: Grant SELECT only
    EXECUTE format('GRANT SELECT ON %I.company_view  TO guest', schema_name);
    RAISE NOTICE 'Privileges granted successfully';

END; 
$$ 

