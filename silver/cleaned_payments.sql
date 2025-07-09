USE DATABASE alpha_db;

USE SCHEMA silver;

CREATE TABLE IF NOT EXISTS cleaned_payments (
    payment_id INT,
    order_id INT,
    amount FLOAT,
    payment_status STRING
);
