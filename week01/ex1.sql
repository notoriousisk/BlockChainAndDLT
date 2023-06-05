-- 1st section --
CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    credit NUMERIC(10, 2)
);

INSERT INTO accounts (id, name, credit) 
VALUES 
    (1, 'Hercules', 1000.00),
    (2, 'Aphrodite', 1000.00),
    (3, 'Poseidon', 1000.00);

BEGIN;  
-- T1 --
SAVEPOINT t1_savepoint;
UPDATE accounts SET credit = credit - 500
	WHERE id = 1;
UPDATE accounts SET credit = credit + 500
	WHERE id = 3;
-- T2 --
SAVEPOINT t2_savepoint;
UPDATE accounts SET credit = credit - 700
	WHERE id = 2;
UPDATE accounts SET credit = credit + 700
	WHERE id = 1;	
-- T3 --
SAVEPOINT t3_savepoint;
UPDATE accounts SET credit = credit - 100
	WHERE id = 2;
UPDATE accounts SET credit = credit + 100
	WHERE id = 3;
COMMIT;

SELECT * FROM accounts;

-- 2nd section --

ALTER TABLE accounts ADD COLUMN BankName varchar(50);
UPDATE accounts SET BankName = 'SberBank' WHERE id IN (1, 3);
UPDATE accounts SET BankName = 'Tinkoff' WHERE id = 2;

BEGIN;
-- T1 --
SAVEPOINT t1_savepoint;
UPDATE accounts SET credit = credit - 500
	WHERE id = 1;
UPDATE accounts SET credit = credit + 500
	WHERE id = 3;
-- T2 --
SAVEPOINT t2_savepoint;
UPDATE accounts SET credit = credit - 700
	WHERE id = 2;
UPDATE accounts SET credit = credit + 670
	WHERE id = 1;
UPDATE accounts SET credit = credit + 30
	WHERE id = 4;
-- T3 --
SAVEPOINT t3_savepoint;
UPDATE accounts SET credit = credit - 100
	WHERE id = 2;
UPDATE accounts SET credit = credit + 70
	WHERE id = 3;
UPDATE accounts SET credit = credit + 30
	WHERE id = 4;
COMMIT;

SELECT * FROM accounts;

-- 3rd section --

CREATE TABLE Ledger (
    ID INTEGER PRIMARY KEY,
    FromAccount INT NOT NULL,
    ToAccount INT NOT NULL,
    Fee INT NOT NULL,
    Amount NUMERIC(10, 2) NOT NULL,
    TransactionDateTime TIMESTAMP NOT NULL
);

BEGIN;

UPDATE accounts SET credit = credit - 500 WHERE id = 1;
UPDATE accounts SET credit = credit + 500 WHERE id = 3;
INSERT INTO Ledger (ID, FromAccount, ToAccount, Fee, Amount, TransactionDateTime) VALUES (1, 1, 3, 0, 500, NOW());

UPDATE accounts SET credit = credit - 700 WHERE id = 2;
UPDATE accounts SET credit = credit + 670 WHERE id = 1;
UPDATE accounts SET credit = credit + 30 WHERE id = 4;
INSERT INTO Ledger (ID, FromAccount, ToAccount, Fee, Amount, TransactionDateTime) VALUES (2, 2, 1, 30, 700, NOW());

UPDATE accounts SET credit = credit - 100 WHERE id = 2;
UPDATE accounts SET credit = credit + 70 WHERE id = 3;
UPDATE accounts SET credit = credit + 30 WHERE id = 4;
INSERT INTO Ledger (ID, FromAccount, ToAccount, Fee, Amount, TransactionDateTime) VALUES (3, 2, 3, 30, 100, NOW());

COMMIT;


SELECT * FROM accounts;

