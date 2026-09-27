-- ============================================
-- GET ACCOUNT BALANCE
-- ============================================

CREATE OR REPLACE FUNCTION get_account_balance (
    p_account_number IN VARCHAR2
)
RETURN NUMBER
AS
    v_balance NUMBER;
BEGIN

    SELECT balance
    INTO v_balance
    FROM account
    WHERE account_number = p_account_number;

    RETURN v_balance;

EXCEPTION

    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(
            -20020,
            'Account not found'
        );

END;
/
