--number of participants by year
SELECT 
	year, 
	count(distinct name) as total_participants,
	count(distinct name)FILTER(WHERE sex='male') as total_male_participants,
	count(distinct name) FILTER(WHERE sex='female') as total_female_participants
FROM public_marts.views
GROUP BY year
ORDER BY year

--total medal by year of each country
SELECT 
 year, team,
 SUM(gold_num) + SUM(silver_num) + SUM(bronze_num) as total_medals
FROM public_marts.views
GROUP BY year, team

--teams winning medals in every Olympic year:
SELECT team
FROM public_marts.views
GROUP BY team
HAVING COUNT(distinct year)=(SELECT COUNT(distinct year) FROM public_marts.views)

/* "France"
"Great Britain"
"Greece"
"Italy"
"Switzerland"
"United States" */

-- first year team get the medal
SELECT team,MIN(year) as first_medal_year
FROM public_marts.views
WHERE total_medal_num <> 0
GROUP BY team