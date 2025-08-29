Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices


1. create dbt project: dbt init olympic_games
~/.dbt/profiles.yml  
2. dbt debug to check connection

https://grok.com/share/c2hhcmQtMw%3D%3D_76bb9825-ec37-4e47-85d0-c0fa4effe563

2. `dbt run -debug`
dbt run --full-refresh: updaate table

to load csv into data warehouse, the easiest way is to run `dbt seed` (assuming u put the .csv files under seeds/ folder)
this will load the csv file into a table in the public schema of the target database

dbt clean
dbt deps
dbt snapshot
dbt run 
dbt test
dbt docs generate
dbt docs serve

when to use dbt: assume u have a datawarehouse and use dbt to mange sql based transofmration

dbt is for the T
to load data, either use:
- custom scripts: python, sql...
- dbt seed for small files
- open source tools like airbyte, fivetran...