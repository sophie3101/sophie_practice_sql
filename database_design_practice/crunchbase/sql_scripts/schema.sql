
-- SET search_path TO dev; 
DROP TABLE IF EXISTS company, company_status,company_location, company_category, company_history;

SELECT 'CREATING TABLE SCHEMA STRUCTURE' as INFO; 

CREATE TABLE company_location (
    location_id SERIAL PRIMARY KEY ,
    country VARCHAR(100),
    state_code VARCHAR(10),
    CONSTRAINT pk_location UNIQUE(country, state_code)
    -- region VARCHAR(100),
    -- city VARCHAR(100), 
    -- CONSTRAINT pk_location UNIQUE(country, state_code, region, city)
);

SELECT 'CREATING company category table' as INFO; 
CREATE TABLE company_category (
    category_id SERIAL PRIMARY KEY, 
    category_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE company_status (
    status_id SERIAL PRIMARY KEY,
    status_name VARCHAR(50) UNIQUE NOT NULL
);

SELECT 'CREATING company table' as INFO; 
CREATE TABLE company (
    company_id SERIAL PRIMARY KEY,
    company_name VARCHAR(255) UNIQUE NOT NULL,
    location_id INT CONSTRAINT fk_location_id REFERENCES company_location(location_id),
    category_id INT CONSTRAINT fk_cat_id REFERENCES company_category(category_id),
    status_id INT CONSTRAINT fk_status_id REFERENCES company_status(status_id),
    founding_date DATE  --allow NULL
);

-- SELECT 'CREATING company history table' as INFO; 
-- CREATE TABLE company_history (
--     company_name VARCHAR(100) CONSTRAINT fk_company REFERENCES company(company_name),
--     event_name VARCHAR(100),
--     event_date DATE,
--     CONSTRAINT pk_history PRIMARY KEY(company_name, event_name, event_date)
-- );

SELECT 'CREATING acquisition_info table' as INFO; 
CREATE TABLE acquisition_info (
    target_company_id NT fk_target_company_id REFERENCES company(company_id),
    acquirer_company_id INT fk_acq_company_id REFERENCES company(company_id),
    acquisition_date DATE NOT NULL, 
    acquisition_amount INT ,
    currency_code VARCHAR(3),
    CONSTRAINT pk_acquisition(target_company_id, acquirer_company_id)
)