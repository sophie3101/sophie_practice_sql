#!/bin/bash
username=$1
hostname=$2

defaultDatabase="postgres"
# # Drop and create the database (must be done from an existing DB like postgres)
# psql -U $username -h $hostname -d $defaultDatabase -c "CREATE DATABASE IF NOT EXISTS crunchbase;"
# psql -U $username -h $hostname -d $defaultDatabase -c "CREATE DATABASE crunchbase;"

dbname=$3
res=$(psql -U $username -h $hostname -d $defaultDatabase -tAc "SELECT 1 FROM pg_database WHERE datname='$dbname'")
#where -c is for command, -t is ouptut only query results, -A disable pretty formatting


if [ "$res" != "1" ]; then
  psql -U $username -h $hostname -d $defaultDatabase -c "CREATE DATABASE $dbname;"
  echo "Database $dbname created."
else
  echo "Database $dbname already exists."
fi