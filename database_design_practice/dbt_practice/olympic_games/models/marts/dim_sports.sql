-- SELECT 
--     {{ dbt_utils.generate_surrogate_key(['sport', 'event']) }} AS sport_id,
--     sport,
--     event
-- FROM {{ ref('staging_athlete_events') }}
-- GROUP BY sport, event

SELECT 
    {{ dbt_utils.generate_surrogate_key(['sport']) }} AS sport_id,
    sport
FROM {{ ref('staging_athlete_events') }}
GROUP BY sport
