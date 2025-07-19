BEGIN;

UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;

-- Safter rollback, data is removed from memory
ROLLBACK;

--RAISE NOTICE: similar to print() to console, does not rollback
--RAISE EXCEPZTION: 