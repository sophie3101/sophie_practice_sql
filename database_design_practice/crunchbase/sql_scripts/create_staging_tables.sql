CREATE SCHEMA IF NOT EXISTS staging;
SET search_path TO staging;
DROP TABLE IF EXISTS staging_companies, staging_acquisitions, staging_funding_rounds,staging_investments;

SELECT 'CREATING TABLE staging_companies' AS INFO; 

CREATE TABLE staging_companies (
    permalink TEXT,
    name TEXT,
    category_code TEXT,
    funding_total_usd TEXT,
    status TEXT,
    country_code TEXT,
    state_code TEXT,
    region TEXT,
    city TEXT,
    funding_rounds INT,
    founded_at DATE,
    founded_month TEXT,
    founded_quarter TEXT,
    founded_year INT,
    first_funding_at TEXT,
    last_funding_at TEXT,
    last_milestone_at TEXT
);

CREATE TABLE staging_acquisitions (
    company_permalink TEXT,
    company_name TEXT,
    company_category_code TEXT,
    company_country_code CHAR(10),
    company_state_code VARCHAR(10),
    company_region TEXT,
    company_city TEXT,
    
    acquirer_permalink TEXT,
    acquirer_name TEXT,
    acquirer_category_code TEXT,
    acquirer_country_code CHAR(10),
    acquirer_state_code VARCHAR(10),
    acquirer_region TEXT,
    acquirer_city TEXT,
    
    acquired_at DATE,
    acquired_month TEXT,
    acquired_quarter TEXT,
    acquired_year INT,
    
    price_amount NUMERIC,
    price_currency_code CHAR(10)
);

CREATE TABLE staging_funding_rounds (
    company_permalink TEXT,
    company_name TEXT,
    company_category_code TEXT,
    company_country_code CHAR(10),
    company_state_code VARCHAR(10),
    company_region TEXT,
    company_city TEXT,
    
    funding_round_type TEXT,
    funded_at DATE,
    funded_month TEXT,
    funded_quarter TEXT,
    funded_year INT,
    
    raised_amount_usd NUMERIC  -- Can be NULL if not disclosed
);

CREATE TABLE staging_investments (
    company_permalink TEXT,
    company_name TEXT,
    company_category_code TEXT,
    company_country_code CHAR(10),
    company_state_code VARCHAR(10),
    company_region TEXT,
    company_city TEXT,

    investor_permalink TEXT,
    investor_name TEXT,
    investor_category_code TEXT,
    investor_country_code CHAR(10),
    investor_state_code VARCHAR(10),
    investor_region TEXT,
    investor_city TEXT,

    funding_round_type TEXT,
    funded_at DATE,
    funded_month TEXT,
    funded_quarter TEXT,
    funded_year INT,

    raised_amount_usd NUMERIC  
);

