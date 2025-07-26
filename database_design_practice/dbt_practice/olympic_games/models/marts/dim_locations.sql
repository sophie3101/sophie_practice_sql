select 
    distinct {{ dbt_utils.generate_surrogate_key(['city']) }} AS location_id,
    city
from {{ref('staging_athlete_events')}}