select 
    {{ dbt_utils.generate_surrogate_key([
        'athletes.athlete_id',
        'teams.team_id',
        'timeline.time_id',
        'locations.location_id',
        'sports.sport_id'
    ]) }} AS fact_id,
    athletes.athlete_id,
    teams.team_id, 
    timeline.time_id, 
    locations.location_id,
    sports.sport_id,
    count(*)FILTER(WHERE events.medal='Gold') as gold_num,
    count(*)FILTER(WHERE events.medal='Silver') as silver_num,
    count(*)FILTER(WHERE events.medal='Bronze') as bronze_num,
    count(*)FILTER(WHERE events.medal is null) as no_medal_num
from {{ref('stg_athlete_events')}} as events
LEFT JOIN {{ref('dim_athletes')}} as athletes 
    ON athletes.name = events.name
LEFT JOIN {{ref('dim_teams')}} as teams 
    ON lower(teams.team) = lower(events.team) AND lower(teams.noc) = lower(events.NOC)
LEFT JOIN {{ref('dim_times')}} as timeline
    ON timeline.year = events.year AND timeline.season = lower(events.season)
LEFT JOIN {{ref('dim_locations')}} as locations 
    ON locations.city = events.city
LEFT JOIN {{ref('dim_sports')}} as sports 
    ON sports.sport = events.sport 
group by athletes.athlete_id, teams.team_id, timeline.time_id, locations.location_id, sports.sport_id