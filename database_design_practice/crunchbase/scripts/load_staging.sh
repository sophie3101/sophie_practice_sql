#!/bin/bash
username=$1
hostname=$2
dbname=$3

psql -U $username -h $hostname -d $dbname -q < sql_scripts/create_staging_tables.sql

echo "Loading file raw_data/crunchbase-companies.csv INTO staging_companies table"
psql -U "$username" -h "$hostname" -d "$dbname" <<EOF
\copy staging_companies FROM 'raw_data/crunchbase-companies.csv' WITH CSV HEADER ENCODING 'LATIN1';
\copy staging_funding_rounds FROM 'raw_data/crunchbase-rounds.csv' WITH CSV HEADER ENCODING 'LATIN1';
\copy staging_investments FROM 'raw_data/crunchbase-investments.csv' WITH CSV HEADER ENCODING 'LATIN1';
\copy staging_acquisitions FROM 'raw_data/crunchbase-acquisitions.csv' WITH CSV HEADER ENCODING 'LATIN1';
EOF
