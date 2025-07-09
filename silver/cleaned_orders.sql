USE DATABASE alpha_db;

USE SCHEMA silver;

CREATE TABLE IF NOT EXISTS cleaned_orders (
    order_id INT,
    customer_id INT,
    order_date TIMESTAMP,
    payment_method STRING
);
