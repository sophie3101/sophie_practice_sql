#!/bin/bash
username=$1
hostname=$2
dbname=$3

psql -U $username -h $hostname -d $dbname -q < sql_scripts/schema/staging_tables_schema.sql

echo "Loading files  INTO STAGING tables"
psql -U "$username" -h "$hostname" -d "$dbname" <<EOF
SET search_path TO staging;
\copy staging_companies FROM 'raw_data/crunchbase-companies.csv' WITH CSV HEADER ENCODING 'LATIN1';
\copy staging_funding_rounds FROM 'raw_data/crunchbase-rounds.csv' WITH CSV HEADER ENCODING 'LATIN1';
EOF
