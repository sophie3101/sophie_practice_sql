BEGIN;

UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;

-- Safter rollback, data is removed from memory
ROLLBACK;

--RAISE NOTICE: similar to print() to console, does not rollback
--RAISE EXCEPZTION: 


-- Now test a negative case inside a savepoint
    SAVEPOINT sp_test_null_violation;
    BEGIN
        -- This will fail (NULL in NOT NULL column)
        INSERT INTO funding_type(funding_type) VALUES (NULL);
    EXCEPTION WHEN not_null_violation THEN
        RAISE NOTICE 'Not null violation caught';
        ROLLBACK TO SAVEPOINT sp_test_null_violation;  -- rollback just this insert
    END;