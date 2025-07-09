-- Database
CREATE DATABASE IF NOT EXISTS alpha_db;
USE DATABASE alpha_db;

-- Schema
CREATE SCHEMA IF NOT EXISTS bronze;
CREATE SCHEMA IF NOT EXISTS silver;
CREATE SCHEMA IF NOT EXISTS gold;

USE SCHEMA bronze;
CREATE OR REPLACE TABLE customers (
    customer_id INTEGER,
    customer_name STRING,
    email STRING,
    country STRING
);

CREATE OR REPLACE TABLE order_items (
    order_item_id INTEGER,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    unit_price DOUBLE
);

CREATE OR REPLACE TABLE orders (
    order_id INTEGER,
    customer_id INTEGER,
    order_date TIMESTAMP,
    payment_method STRING
);

CREATE OR REPLACE TABLE payments (
    payment_id INTEGER,
    order_id INTEGER,
    amount DOUBLE,
    payment_status STRING
);

CREATE OR REPLACE TABLE products (
    product_id INTEGER,
    product_name STRING,
    category STRING,
    price DOUBLE
);

-- File Format
CREATE OR REPLACE FILE FORMAT ecommerce_csv_format
TYPE = 'CSV'
SKIP_HEADER = 1
FIELD_OPTIONALLY_ENCLOSED_BY = '"';

-- Storage Integration for secure access
CREATE OR REPLACE STORAGE INTEGRATION ecommerce_s3_integration
TYPE = EXTERNAL_STAGE
STORAGE_PROVIDER = S3
ENABLED = TRUE
STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::478024548952:role/pipeline-alpha-role'
STORAGE_ALLOWED_LOCATIONS = ('s3://pipeline-alpha-bucket/');

