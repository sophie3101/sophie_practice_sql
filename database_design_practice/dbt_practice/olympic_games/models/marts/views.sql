{{ config(materialized='view') }}

select 
    athletes.name,
    athletes.sex,
    athletes.age,
    athletes.height,
    athletes.weight,
    teams.team,
    teams.noc,
    times.year,
    times.season,
    sports.sport,
    events.gold_num,
    events.silver_num,
    events.bronze_num, 
    events.no_medal_num,
    events.gold_num + events.silver_num + events.bronze_num as total_medal_num
from {{ref('fact_athlete_events')}} as events 
JOIN {{ref('dim_teams')}} as teams 
    ON teams.team_id = events.team_id 
JOIN {{ref('dim_athletes')}} as athletes
    ON athletes.athlete_id = events.athlete_id
JOIN {{ref('dim_times')}} as times 
    ON times.time_id = events.time_id
JOIN {{ref('dim_sports')}} as sports 
    ON sports.sport_id = events.sport_id 
