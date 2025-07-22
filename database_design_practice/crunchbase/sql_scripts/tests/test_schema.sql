DO $$
DECLARE 
    loc_id INT;
    cat_id INT;
    stat_id INT;
    comp_id INT;
    fund_type_id INT;
BEGIN
    INSERT INTO company_location (country, state_code) VALUES ('USA', 'CA') RETURNING location_id INTO loc_id;
    INSERT INTO company_category (category_name) VALUES ('Tech') RETURNING category_id INTO cat_id;
    INSERT INTO company_status (status_name) VALUES ('Active') RETURNING status_id INTO stat_id;
    INSERT INTO funding_type (funding_type) VALUES ('angel') RETURNING type_id INTO fund_type_id;

    --expected success
    INSERT INTO company (company_name, location_id, category_id, status_id, founding_date)
        VALUES ('TestCorp', loc_id, cat_id, stat_id, '2020-01-01')
        RETURNING company_id INTO comp_id;

    RAISE NOTICE 'Insert into company table successful';

    INSERT INTO funding_rounds (company_id, funding_type_id, funded_at, funding_amount)
        VALUES (comp_id, fund_type_id, '2020-05-20', 1000000);
    RAISE NOTICE 'Insert into funding_rounds table successful';

    -- duplicate records
    BEGIN
        --expected failure when insert same company 2nd time
        INSERT INTO company (company_name, location_id, category_id, status_id, founding_date)
            VALUES ('TestCorp', loc_id, cat_id, stat_id, '2020-01-01');
        INSERT INTO funding_rounds (company_id, funding_type_id, funded_at, funding_amount)
            VALUES (comp_id, fund_type_id, '2020-05-20', 1000000);
    EXCEPTION WHEN unique_violation THEN
        RAISE NOTICE 'duplicate key value violates unique constraint';
    END;

    -- invalid data type 
    BEGIN 
        INSERT INTO company (company_name, location_id, category_id, status_id, founding_date)
            VALUES('CorpB', loc_id, cat_id, stat_id, 'not date type');
        EXCEPTION WHEN others THEN
            RAISE NOTICE 'wrong date format';    
    END;

    -- check NULL violation
    BEGIN
        INSERT INTO funding_type(funding_type) VALUES (NULL);
        INSERT INTO company (company_name, location_id, category_id, status_id, founding_date)
            VALUES ('TestCorpB', loc_id, NULL, stat_id, '2020-01-01');
        INSERT INTO funding_rounds (company_id, funding_type_id, funded_at, funding_amount)
            VALUES (comp_id, NULL, '2020-05-20', 1000000);
    EXCEPTION WHEN not_null_violation THEN 
        RAISE NOTICE 'cannot be NULL values';
    END;

    -- check_violation
    BEGIN
        INSERT INTO funding_rounds (company_id, funding_type_id, funded_at, funding_amount)
            VALUES (comp_id, 1, '2020-05-21', -1000000);
    EXCEPTION WHEN check_violation THEN 
        RAISE NOTICE 'funding amount have to be a positive number';
    END;

    BEGIN
        INSERT INTO company (company_name, location_id, category_id, status_id, founding_date)
            VALUES ('CompanyA', loc_id, cat_id, stat_id, CURRENT_DATE+INTERVAL '1day');
    EXCEPTION WHEN check_violation THEN 
        RAISE NOTICE 'founding date has to be before or the current date';
    END;

    BEGIN
        INSERT INTO funding_type(funding_type) VALUES ('');
        INSERT INTO company_category(category_name) VALUES ('');
    EXCEPTION WHEN check_violation THEN 
        RAISE NOTICE 'cannot be empty string';
    END;

END;
$$;