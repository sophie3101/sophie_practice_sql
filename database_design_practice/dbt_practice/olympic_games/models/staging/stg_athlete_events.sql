{{ config(materialized='view', schema='staging') }} --either inline config or in dbt_project.yml

select 
    name, 
    CASE 
        WHEN "sex" = 'M' THEN 'male'
        WHEN "sex" = 'F' THEN 'female'
        ELSE 'unknown'
    END as sex,
    NULLIF(age, 'NA')::NUMERIC as age , 
    NULLIF(height, 'NA')::FLOAT as height,
    NULLIF(weight, 'NA')::FLOAT as weight,
    SPLIT_PART("team", '-', 1) As team,
    noc,
    year::INTEGER,
    season,
    city,
    sport,
    event,
    NULLIF("medal", 'NA') AS medal
from {{source('raw_layer', 'athlete_events')}}