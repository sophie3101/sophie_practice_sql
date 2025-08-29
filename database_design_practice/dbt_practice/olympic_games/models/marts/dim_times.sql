select 
    {{dbt_utils.generate_surrogate_key(['Year', 'Season'])}} as time_id, 
    year::INTEGER,
    lower(season)::TEXT as season
FROM {{ ref('stg_athlete_events') }}
group by year, season