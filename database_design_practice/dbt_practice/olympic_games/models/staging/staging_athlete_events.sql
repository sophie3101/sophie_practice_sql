{{ config(materialized='view', schema='staging') }} --either inline config or in dbt_project.yml

with events as (
    select *
    from {{ref('athlete_events')}}
)

select 
    "Name" AS name, 
    CASE 
        WHEN "Sex" = 'M' THEN 'male'
        WHEN "Sex" = 'F' THEN 'female'
        ELSE 'Unknown'
    END as sex,
    NULLIF("Age", 'NA')::NUMERIC AS age, 
    NULLIF("Height", 'NA')::FLOAT AS height,
    NULLIF("Weight", 'NA')::FLOAT AS weight,
    SPLIT_PART("Team", '-', 1) As team,
    "NOC" AS noc,
    "Year" AS "year",
    "Season" as season,
    "City" as city,
    "Sport" as sport,
    "Event" as event,
    NULLIF("Medal", 'NA') AS medal
from events 