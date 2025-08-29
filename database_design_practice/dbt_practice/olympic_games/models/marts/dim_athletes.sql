select 
    {{ dbt_utils.generate_surrogate_key(['name']) }} as athlete_id,
    name,
    max(sex) as sex,
    max(age)::INT as age,
    max(height)::NUMERIC as height,
    max(weight)::NUMERIC as weight
from {{ref('stg_athlete_events')}}
group by name