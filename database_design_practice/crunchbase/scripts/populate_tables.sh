#!/bin/bash
username=$1
hostname=$2
dbname=$3

# create table schema 
psql -U $username -h $hostname -d $dbname  < sql_scripts/schema.sql


#populate tables
# only select USA company
psql -U $username -h $hostname -d $dbname  < sql_scripts/load_tables.sql