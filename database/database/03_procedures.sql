-- ============================================
-- DEPOSIT PROCEDURE
-- ============================================

CREATE OR REPLACE PROCEDURE deposit_money (
    p_account_number IN VARCHAR2,
    p_amount         IN NUMBER
)
AS
    v_account_id NUMBER;
    v_status     VARCHAR2(20);
BEGIN

    IF p_amount <= 0 THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'Deposit amount must be greater than zero'
        );
    END IF;

    SELECT account_id, status
    INTO v_account_id, v_status
    FROM account
    WHERE account_number = p_account_number
    FOR UPDATE;

    IF v_status <> 'ACTIVE' THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'Account is not active'
        );
    END IF;

    UPDATE account
    SET balance = balance + p_amount
    WHERE account_id = v_account_id;

    INSERT INTO bank_transaction (
        transaction_reference,
        account_id,
        transaction_type,
        amount,
        description
    )
    VALUES (
        'DEP-' || TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF3'),
        v_account_id,
        'DEPOSIT',
        p_amount,
        'Cash deposit'
    );

    COMMIT;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(
            -20003,
            'Account not found'
        );

    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/
-- ============================================
-- WITHDRAWAL PROCEDURE
-- ============================================

CREATE OR REPLACE PROCEDURE withdraw_money (
    p_account_number IN VARCHAR2,
    p_amount         IN NUMBER
)
AS
    v_account_id NUMBER;
    v_balance    NUMBER;
    v_status     VARCHAR2(20);
BEGIN

    IF p_amount <= 0 THEN
        RAISE_APPLICATION_ERROR(
            -20004,
            'Withdrawal amount must be greater than zero'
        );
    END IF;

    SELECT account_id, balance, status
    INTO v_account_id, v_balance, v_status
    FROM account
    WHERE account_number = p_account_number
    FOR UPDATE;

    IF v_status <> 'ACTIVE' THEN
        RAISE_APPLICATION_ERROR(
            -20005,
            'Account is not active'
        );
    END IF;

    IF v_balance < p_amount THEN
        RAISE_APPLICATION_ERROR(
            -20006,
            'Insufficient account balance'
        );
    END IF;

    UPDATE account
    SET balance = balance - p_amount
    WHERE account_id = v_account_id;

    INSERT INTO bank_transaction (
        transaction_reference,
        account_id,
        transaction_type,
        amount,
        description
    )
    VALUES (
        'WDL-' || TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF3'),
        v_account_id,
        'WITHDRAWAL',
        p_amount,
        'Cash withdrawal'
    );

    COMMIT;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(
            -20007,
            'Account not found'
        );

    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/
