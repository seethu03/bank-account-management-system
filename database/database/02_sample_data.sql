-- ============================================
-- SAMPLE DATA
-- ============================================

-- CUSTOMER DATA

INSERT INTO customer
(first_name, last_name, email, phone)
VALUES
('Seethu', 'Keerthana', 'seethu@gmail.com', '9876543210');

INSERT INTO customer
(first_name, last_name, email, phone)
VALUES
('Rahul', 'Kumar', 'rahul@gmail.com', '9876543211');

INSERT INTO customer
(first_name, last_name, email, phone)
VALUES
('Priya', 'Sharma', 'priya@gmail.com', '9876543212');


-- ACCOUNT DATA

INSERT INTO account
(account_number, customer_id, account_type, balance)
VALUES
('1000000001', 1, 'SAVINGS', 50000);

INSERT INTO account
(account_number, customer_id, account_type, balance)
VALUES
('1000000002', 2, 'SAVINGS', 25000);

INSERT INTO account
(account_number, customer_id, account_type, balance)
VALUES
('1000000003', 3, 'CURRENT', 75000);


COMMIT;
