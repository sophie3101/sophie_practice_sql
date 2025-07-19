-- investments contain consistent funding type
SELECT * 
FROM staging.staging_investments
WHERE NOT EXISTS (SELECT 1 FROM funding_type WHERE funding_type.funding_type != funding_round_type );

EXPLAIN
SELECT * 
FROM staging.staging_investments
WHERE NOT EXISTS (SELECT 1 FROM company WHERE trim(company.company_name) = TRIm(LOWER(REPLACE(company_permalink, '/company/', '')) ));