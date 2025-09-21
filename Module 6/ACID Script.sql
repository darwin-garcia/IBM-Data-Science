CREATE PROCEDURE TRANSACTION_ROSE()
LANGUAGE PLPGSQL AS
$$
    BEGIN
	    UPDATE BankAccounts
	    SET Balance = Balance-200
	    WHERE AccountName = 'Rose';
		
	    UPDATE BankAccounts
	    SET Balance = Balance+200
	    WHERE AccountName = 'Shoe Shop';
		
	    UPDATE ShoeShop
	    SET Stock = Stock-1
	    WHERE Product = 'Boots';
		
	    UPDATE BankAccounts
	    SET Balance = Balance-100
	    WHERE AccountName = 'Rose';
    COMMIT;
	ROLLBACK;
END;
$$

CREATE PROCEDURE TRANSACTION_JAMES()
LANGUAGE PLPGSQL AS
$$
    BEGIN
	    UPDATE BankAccounts
	    SET Balance = Balance-1200
	    WHERE AccountName = 'James';
		
	    UPDATE BankAccounts
	    SET Balance = Balance+1200
	    WHERE AccountName = 'Shoe Shop';
		
	    UPDATE ShoeShop
	    SET Stock = Stock-4
	    WHERE Product = 'Boots';
		
	    UPDATE BankAccounts
	    SET Balance = Balance-150
	    WHERE AccountName = 'James';
    COMMIT;
	ROLLBACK;
END;
$$


DROP PROCEDURE TRANSACTION_ROSE();
DROP PROCEDURE TRANSACTION_JAMES();
CALL TRANSACTION_ROSE();
CALL TRANSACTION_JAMES();

SELECT * FROM BankAccounts;
SELECT * FROM ShoeShop;