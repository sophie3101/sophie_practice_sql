CREATE TEMP TABLE tmp AS 
SELECT company_name, cat.category_name,  sta.status_name, loc.country, loc.state_code
FROM company c 
JOIN company_location loc ON loc.location_id = c.location_id
JOIN company_status sta ON sta.status_id = c.status_id
JOIN company_category cat ON cat.category_id = c.category_id;
-- top 10 state which the most number of companies
select state_code, COUNT(distinct company_name)
FROM tmp
GROUP BY state_code 
ORDER BY COUNT(distinct company_name) DESC
LIMIT 10;
/*"CA"	6539
"NY"	1820
"MA"	1399
"TX"	813
"WA"	658
"PA"	461
"FL"	432
"CO"	431
"IL"	416
"VA"	347
*/
--      break down by type of companies
select 
	state_code, 
	COUNT(distinct company_name) as total_companies,
	COUNT(distinct company_name) FILTER(WHERE status_name='operating') as n_opearting_companies,
	COUNT(distinct company_name) FILTER(WHERE status_name='ipo') as n_ipo_companies,
	COUNT(distinct company_name) FILTER(WHERE status_name='acquired') as n_acquired_companies,
	COUNT(distinct company_name) FILTER(WHERE status_name='closed') as n_closed_companies
FROM tmp
GROUP BY state_code 
ORDER BY COUNT(distinct company_name) DESC
LIMIT 10;
/*
state_code	total_companies	n_opearting_companies	n_ipo_companies	n_acquired_companies	n_closed_companies
CA	6539	5369	116	833	221
NY	1820	1563	25	162	70
MA	1399	1175	44	148	32
TX	813	700	17	68	28
WA	658	553	10	75	20
PA	461	405	10	26	20
FL	432	388	16	15	13
CO	431	368	8	37	18
IL	416	365	7	28	16
VA	347	304	8	27	8
*/ 

-- company breakdown by industry type and state
select 
	state_code, category_name,
	COUNT(distinct company_name)
FROM tmp
GROUP BY state_code, category_name
ORDER BY COUNT(distinct company_name) DESC

--company count breakdown by industry type
select 
	category_name,
	COUNT(distinct company_name)
FROM tmp
GROUP BY  category_name
ORDER BY COUNT(distinct company_name) DESC
LIMIT 5;
/*
"software"	2671
"biotech"	2052
"web"	1613
"mobile"	1128
"enterprise"	1117
*/

--showing number of companies created by year
select EXTRACT (YEAR FROM founding_date),
		COUNT(distinct company_name)
FROM tmp
GROUP BY EXTRACT (YEAR FROM founding_date)
ORDER BY EXTRACT (YEAR FROM founding_date)

-- which companies going through many funding round
select distinct company_name,  
COUNT(funded_at) OVER(PARTITION BY company_name) AS n_funded_events
FROM company_view
WHERE funding_type IS NOT NULL
ORDER BY n_funded_events DESC
LIMIT 10;
-- list the funding type companies going through
select company_name,  
COUNT(funded_at) AS n_funding_events,
STRING_AGG(distinct funding_type, ',')
FROM company_view
WHERE funding_type IS NOT NULL
GROUP BY company_name
ORDER BY n_funding_events DESC;
/*
"aviir"	14
"pro-pharmaceuticals"	13
"telecommunication-systems"	12
"visualant"	12
"aperto-networks"	11
"fab-com"	11
"facebook"	11
"infinia"	11
"instamed"	11
"intrexon-corporation"	11
*/
-- companies receive the most funding
select distinct company_name,  
SUM(funding_amount) OVER(PARTITION BY company_name) AS total_funding_amount
FROM company_view
WHERE funding_type IS NOT NULL
ORDER BY total_funding_amount DESC
LIMIT 10;
/*
"clearwire"	5700000000
"verizon"	3985050000
"sigmacare"	2600000000
"facebook"	2425700000
"carestream-health"	2400000000
"solyndra"	1653860000
"fisker"	1451000000
"comcast"	1275000000
"terra-gen-power"	1200000000
"twitter"	1160166511
*/
