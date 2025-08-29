with cte as (
    select "NOC" as noc,
            region
    from {{ref('noc_regions')}}
)
select 
    {{dbt_utils.generate_surrogate_key(['team', 'events.noc'])}} as team_id,
    team,
    events.noc,
    cte.region
from {{ref('stg_athlete_events')}} as events
LEFT JOIN  cte 
    ON cte.noc = events.noc
group by team, events.noc, cte.region