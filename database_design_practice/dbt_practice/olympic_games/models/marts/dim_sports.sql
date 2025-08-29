SELECT 
    {{ dbt_utils.generate_surrogate_key(['sport']) }} AS sport_id,
    sport
FROM {{ ref('stg_athlete_events') }}
GROUP BY sport
