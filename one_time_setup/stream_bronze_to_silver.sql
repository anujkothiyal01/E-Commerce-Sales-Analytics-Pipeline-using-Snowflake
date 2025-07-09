USE SCHEMA alpha_db.bronze;

CREATE OR REPLACE STREAM stream_customers ON TABLE customers;
CREATE OR REPLACE STREAM stream_orders ON TABLE orders;
CREATE OR REPLACE STREAM stream_payments ON TABLE payments;
CREATE OR REPLACE STREAM stream_order_items ON TABLE order_items;
CREATE OR REPLACE STREAM stream_products ON TABLE products;