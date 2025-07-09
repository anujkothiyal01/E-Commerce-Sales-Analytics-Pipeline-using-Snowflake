USE DATABASE alpha_db;

USE SCHEMA silver;

CREATE TABLE IF NOT EXISTS enriched_order_items (
    order_item_id INT,
    order_id INT,
    product_id INT,
    product_name STRING,
    category STRING,
    quantity INT,
    unit_price FLOAT,
    total_price FLOAT
);
