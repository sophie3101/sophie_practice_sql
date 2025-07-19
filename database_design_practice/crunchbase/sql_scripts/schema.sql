
-- SET search_path TO public; 
DROP TABLE IF EXISTS  funding_type, funding_rounds, acquisition_info, company_status,company_location, company_category, company;

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

SELECT 'CREATING funding_rounds table' as INFO;
CREATE TABLE funding_type (
    type_id SERIAL PRIMARY KEY,
    funding_type VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE funding_rounds (
    id SERIAL PRIMARY KEY, 
    company_id INT REFERENCES company(company_id),
    funding_type_id INT REFERENCES funding_type(type_id),
    funded_at DATE NOT NULL, 
    funding_amount BIGINT NOT NULL
    -- PRIMARY KEY(company_id, funding_type_id, funded_at, funding_amount)
);

SELECT 'CREATING investment table' as INFO;
CREATE TABLE investing_rounds (
    id SERIAL PRIMARY KEY,
    funding_event_id INT REFERENCES funding_rounds(id),
    invester_company_id INT REFERENCES company(company_id),
    investment_amount BIGINT NOT NULL
)
-- SELECT 'CREATING acquisition_infotable' as INFO; 
-- CREATE TABLE acquisition_info (
--     target_company_id INT CONSTRAINT fk_target_company_id REFERENCES company(company_id),
--     acquirer_company_id INT CONSTRAINT fk_acq_company_id REFERENCES company(company_id),
--     acquisition_date DATE NOT NULL, 
--     acquisition_amount BIGINT ,
--     currency_code VARCHAR(3),
--     CONSTRAINT pk_acquisition PRIMARY KEY(target_company_id, acquirer_company_id)
-- );