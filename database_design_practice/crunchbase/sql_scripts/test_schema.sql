DO $$
BEGIN
    INSERT INTO company_location (country, state_code) VALUES ('USA', 'CA');
    INSERT INTO company_category (category_name) VALUES ('Tech');
    INSERT INTO company_status (status_name) VALUES ('Active'), ('Closed');
    INSERT INTO funding_type (funding_type) VALUES ('angel'),('series-a');
    --expected success
    INSERT INTO company (company_name, location_id, category_id, status_id, founding_date)
        VALUES ('TestCorp', 1, 1, 1, '2020-01-01');

    RAISE NOTICE 'Insert into company table successful';

    INSERT INTO funding_rounds (company_id, funding_type_id, funded_at, funding_amount)
        VALUES (1, 1, '2020-05-20', 1000000);
    RAISE NOTICE 'Insert into funding_rounds table successful';

    -- duplicate records
    BEGIN
        --expected failure when insert same company 2nd time
        INSERT INTO company (company_name, location_id, category_id, status_id, founding_date)
            VALUES ('TestCorp', 1, 1, 1, '2020-01-01');
        INSERT INTO funding_rounds (company_id, funding_type_id, funded_at, funding_amount)
            VALUES (1, 1, '2020-05-20', 1000000);
    EXCEPTION WHEN unique_violation THEN
        RAISE NOTICE 'duplicate key value violates unique constraint';
    END;

    -- check NULL violation
    BEGIN
        INSERT INTO funding_type(funding_type) VALUES (NULL);
        INSERT INTO company (company_name, location_id, category_id, status_id, founding_date)
            VALUES ('TestCorpB', 1, NULL, 1, '2020-01-01');
        INSERT INTO funding_rounds (company_id, funding_type_id, funded_at, funding_amount)
            VALUES (1, NULL, '2020-05-20', 1000000);
    EXCEPTION WHEN not_null_violation THEN 
        RAISE NOTICE 'cannot be NULL values';
    END;
    -- check_violation
    BEGIN
        INSERT INTO funding_rounds (company_id, funding_type_id, funded_at, funding_amount)
            VALUES (1, 1, '2020-05-21', -1000000);
    EXCEPTION WHEN check_violation THEN 
        RAISE NOTICE 'funding amount have to be a positive number';
    END;

    BEGIN
        INSERT INTO company (company_name, location_id, category_id, status_id, founding_date)
            VALUES ('CompanyA', 1, 1, 1, CURRENT_DATE+INTERVAL '1day');
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