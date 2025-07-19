#!/bin/bash
username=$1
hostname=$2

defaultDatabase="postgres"
dbname=$3

res=$(psql -U $username -h $hostname -d $defaultDatabase -tAc "SELECT 1 FROM pg_database WHERE datname='$dbname'")
#where -c is for command, -t is ouptut only query results, -A disable pretty formatting


if [ "$res" != "1" ]; then
  psql -U $username -h $hostname -d $defaultDatabase -c "CREATE DATABASE $dbname;"
  echo "Database $dbname created."
else
  echo "Database $dbname already exists."
fi