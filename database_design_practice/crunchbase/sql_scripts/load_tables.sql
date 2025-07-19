-- SET search_path TO dev;
SELECT 'adding data into company_location' as INFO; 

CREATE TEMP TABLE company_tmp AS 
SELECT REPLACE(permalink, '/company/', '') as company_name,	
category_code,	funding_total_usd, status as company_status	,
country_code,	
CASE
	WHEN state_code IS NOT NULL THEN state_code
	WHEN state_code IS  NULL  AND region IN ('SF Bay','San Diego', 'Los Angeles') THEN 'CA'
	WHEN state_code IS  NULL  AND region='New York' THEN 'NY'
	WHEN state_code IS  NULL  AND region='Boston' THEN 'MA'
	WHEN state_code IS  NULL  AND region='Portland' THEN 'OR'
	WHEN state_code IS  NULL  AND region='Atlanta' THEN 'GA'
	WHEN state_code IS  NULL  AND region='Georgia' THEN 'GA'
	WHEN state_code IS  NULL  AND region IN ('Pittsburg','Philadelphia') THEN 'PA'
	WHEN state_code IS  NULL  AND region IN ('Phoenix','Salt Lake City') THEN 'AZ'
	WHEN state_code IS  NULL  AND region IN ('Chicago') THEN 'IL'
	WHEN state_code IS  NULL  AND region IN ('Colorado') THEN 'CO'
	WHEN state_code IS  NULL  AND region IN ('Washington DC') THEN 'VA'
	WHEN state_code IS  NULL  AND region IN ('North Carolina') THEN 'NC'
	WHEN state_code IS  NULL  AND region IN ('Austin', 'Houston') THEN 'TX'
	WHEN state_code IS  NULL  AND region IN ('Kansas City') THEN 'KS'
	ELSE 'unknown'
END AS state_code ,
lower(REPLACE(city, ',','')) as city	,funding_rounds,	founded_at
,founded_month	,founded_quarter	,founded_year	,first_funding_at	,
last_funding_at, last_milestone_at
FROM staging_companies
WHERE region NOT IN ('Stockholm', 'Shenzhen', 'TBD', 'United States - Other') ;


INSERT INTO company_location(country, state_code)
SELECT DISTINCT country_code, state_code
FROM company_tmp
WHERE state_code != 'unknown';

SELECT 'adding data into company_category' as INFO; 
INSERT INTO company_category(category_name)
SELECT distinct category_code
FROM staging_companies
WHERE category_code IS NOT NULL;

SELECT 'adding data into company_status' as INFO; 
INSERT INTO company_status(status_name)
SELECT distinct status 
FROM staging_companies;

SELECT 'adding data into company' as INFO; 
INSERT INTO company(company_name, location_id, category_id, status_id, founding_date)
SELECT company_name, location_id, category_id, sta.status_id, tmp.founded_at
FROM company_tmp tmp
JOIN company_location loc 
    ON loc.country = tmp.country_code AND loc.state_code = tmp.state_code
JOIN company_category cat 
    ON cat.category_name = tmp.category_code
JOIN company_status sta 
	ON sta.status_name=tmp.company_status;
