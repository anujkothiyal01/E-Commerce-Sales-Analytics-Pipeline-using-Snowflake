USE DATABASE alpha_db;
USE SCHEMA silver;

CREATE OR REPLACE TASK task_stream_has_data
WAREHOUSE = compute_wh
SCHEDULE = '1 MINUTE'
WHEN
    SYSTEM$STREAM_HAS_DATA('bronze.stream_customers')
    OR SYSTEM$STREAM_HAS_DATA('bronze.stream_orders')
    OR SYSTEM$STREAM_HAS_DATA('bronze.stream_order_items')
    OR SYSTEM$STREAM_HAS_DATA('bronze.stream_payments')
    OR SYSTEM$STREAM_HAS_DATA('bronze.stream_products')
AS
    CALL sp_run_silver();