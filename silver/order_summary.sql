USE DATABASE alpha_db;

USE SCHEMA silver;

CREATE TABLE IF NOT EXISTS order_summary (
    order_id INT,
    order_date TIMESTAMP,
    customer_id INT,
    customer_name STRING,
    country STRING,
    product_name STRING,
    category STRING,
    quantity INT,
    unit_price FLOAT,
    line_total FLOAT,
    payment_amount FLOAT,
    payment_status STRING
);
