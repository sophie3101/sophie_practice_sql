https://platform.stratascratch.com/coding/10156-number-of-units-per-nationality?code_type=1

We have data on rental properties and their owners. Write a query that figures out how many different apartments (use unit_id) are owned by people under 30, broken down by their nationality. We want to see which nationality owns the most apartments, so make sure to sort the results accordingly.
```select nationality, COUNT(distinct unit_id) as apartment_count 
from airbnb_hosts
JOIN airbnb_units
    ON airbnb_units.host_id = airbnb_hosts.host_id 
WHERE  airbnb_units.unit_type = 'Apartment' AND airbnb_hosts.age <30
GROUP BY nationality
ORDER BY apartment_count DESC
```