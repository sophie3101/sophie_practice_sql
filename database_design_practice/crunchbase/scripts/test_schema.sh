#!/bin/bash
username=$1
hostname=$2
dbname=$3

echo "Loading files  INTO test schema"
psql -U "$username" -h "$hostname" -d "$dbname" <<EOF
CREATE SCHEMA IF NOT EXISTS test;
SET search_path TO test;
\i sql_scripts/schema/company_schema.sql
\i sql_scripts/test_schema.sql
EOF

# psql -U "$username" -h "$hostname" -d "$dbname" <<EOF
# CREATE SCHEMA IF NOT EXISTS test;
# SET search_path TO test;
# -- Create the "pgtap" extension, only ned to run once per database
# CREATE EXTENSION IF NOT EXISTS pgtap;
# \i sql_scripts/pgtap.sql;
# EOF

