
DROP TABLE IF EXISTS  funding_type, funding_rounds,  company_status, company_location, company_category, company ;

\echo ============================================
\echo CREATING SCHEMA TABLES
\echo ============================================

CREATE TABLE company_location (
    location_id SERIAL PRIMARY KEY ,
    country VARCHAR(100) NOT NULL ,
    state_code VARCHAR(10) NOT NULL,
    CONSTRAINT pk_location UNIQUE(country, state_code)
);
-- adding NOT NULL to

CREATE TABLE company_category (
    category_id SERIAL PRIMARY KEY, 
    category_name VARCHAR(100) UNIQUE NOT NULL CHECK(category_name <> '')
);

-- SELECT 'CREATING company_category table' as INFO; 
CREATE TABLE company_status (
    status_id SERIAL PRIMARY KEY,
    status_name VARCHAR(50) UNIQUE NOT NULL CHECK(status_name<> '')
);

CREATE TABLE company (
    company_id SERIAL PRIMARY KEY,
    company_name VARCHAR(255) UNIQUE NOT NULL CHECK(company_name <> ''),
    location_id INT NOT NULL CONSTRAINT fk_location_id REFERENCES company_location(location_id),
    category_id INT NOT NULL CONSTRAINT fk_cat_id REFERENCES company_category(category_id) ,
    status_id INT NOT NULL CONSTRAINT fk_status_id REFERENCES company_status(status_id),
    founding_date DATE  CHECK(founding_date <= CURRENT_DATE)--allow NULL if not disclosed
);


CREATE TABLE funding_type (
    type_id SERIAL PRIMARY KEY,
    funding_type VARCHAR(50) UNIQUE NOT NULL CHECK(funding_type <> '')
);

CREATE TABLE funding_rounds (
    id SERIAL PRIMARY KEY, 
    company_id INT NOT NULL REFERENCES company(company_id),
    funding_type_id INT NOT NULL REFERENCES funding_type(type_id),
    funded_at DATE NOT NULL, 
    funding_amount NUMERIC NOT NULL CHECK(funding_amount > 0)
);



--add to sys catalog. e.g
COMMENT ON TABLE company IS 'Stores information about companies(target companies), including their name, location, category, and status and funding history';
COMMENT ON COLUMN company.founding_date IS 'Date the company was founded; NULL if unknown';

-- CREATE INDEX index_name ON table_name (column_name);