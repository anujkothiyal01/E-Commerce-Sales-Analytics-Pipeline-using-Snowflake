USE DATABASE alpha_db;

USE SCHEMA silver;

CREATE TABLE IF NOT EXISTS cleaned_customers (
    customer_id INT,
    customer_name STRING,
    email STRING,
    country STRING
);
