USE DATABASE alpha_db;
USE SCHEMA silver;

CREATE OR REPLACE STREAM stream_gold_customers ON TABLE customers;
CREATE OR REPLACE STREAM stream_gold_orders ON TABLE orders;
CREATE OR REPLACE STREAM stream_gold_payments ON TABLE payments;
CREATE OR REPLACE STREAM stream_gold_order_items ON TABLE order_items;
CREATE OR REPLACE STREAM stream_gold_products ON TABLE products;