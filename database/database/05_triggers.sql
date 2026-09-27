-- ============================================
-- ACCOUNT BALANCE AUDIT TRIGGER
-- ============================================

CREATE OR REPLACE TRIGGER trg_account_balance_audit
AFTER UPDATE OF balance ON account
FOR EACH ROW
BEGIN

    IF :OLD.balance <> :NEW.balance THEN

        INSERT INTO audit_log (
            account_id,
            action_type,
            old_balance,
            new_balance
        )
        VALUES (
            :NEW.account_id,
            'BALANCE_UPDATE',
            :OLD.balance,
            :NEW.balance
        );

    END IF;

END;
/
