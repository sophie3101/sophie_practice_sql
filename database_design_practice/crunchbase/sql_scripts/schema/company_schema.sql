

DROP VIEW company_view;
DROP TABLE IF EXISTS  funding_type, funding_rounds,  company_status, company_location, company_category, company ;

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

-- create view (for data visualization)
CREATE OR REPLACE VIEW company_view AS 
SELECT company_name, cat.category_name,  sta.status_name, loc.country, loc.state_code, c.founding_date, ft.funding_type,r.funded_at, r.funding_amount
FROM company c 
JOIN company_location loc ON loc.location_id = c.location_id
JOIN company_status sta ON sta.status_id = c.status_id
JOIN company_category cat ON cat.category_id = c.category_id
LEFT JOIN funding_rounds r ON r.company_id=c.company_id
LEFT JOIN funding_type ft ON ft.type_id = r.funding_type_id;

--add to sys catalog. e.g
COMMENT ON TABLE company IS 'Stores information about companies(target companies), including their name, location, category, and status and funding history';
COMMENT ON COLUMN company.founding_date IS 'Date the company was founded; NULL if unknown';

-- CREATE INDEX TO Do
--CREATE FUNCTIONS
CREATE OR REPLACE FUNCTION insert_company_category(in_category_name VARCHAR)
RETURNS INT 
AS $$
DECLARE 
    cat_id INT;
BEGIN 
    -- Check if category exists
    SELECT category_id INTO cat_id
    FROM company_category 
    WHERE category_name = in_category_name;

    -- if not, do the insert
    IF cat_id IS NULL THEN 
        INSERT INTO company_category(category_name) 
        VALUES (in_category_name)
        RETURNING category_id INTO cat_id;
    END IF;

    RETURN cat_id;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION insert_company_location(country_ VARCHAR, state_code_ VARCHAR)
RETURNS INT 
AS $$
DECLARE 
    location_id_ INT;
BEGIN
    WITH cte AS (
        INSERT INTO company_location(country, state_code)
        VALUES (country_, state_code_)
        ON CONFLICT (country, state_code) DO NOTHING
        RETURNING location_id
    )
    SELECT location_id INTO location_id_
    FROM cte
    UNION ALL
    SELECT location_id
    FROM company_location
    WHERE country = country_ AND state_code = state_code_
    LIMIT 1;

    RETURN location_id_;
END;
$$ LANGUAGE plpgsql;
