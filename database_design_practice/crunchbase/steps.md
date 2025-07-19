0. Go to the current directory of the project
1. connect to the database, create database if not exists

```bash scripts/init_db.sh u249637 localhost crunchbase```

2. load content of input files to temp tables

```bash scripts/load_staging.sh u249637 localhost crunchbase```

3. Populate table
```bash scripts/populate_tables.sh u249637 localhost crunchbase```

