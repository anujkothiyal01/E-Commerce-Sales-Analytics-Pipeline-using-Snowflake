-- ** NEEDS To Automate this using Airflow/Tasks

-- Data is stuck on bronze, - will have to take it via stream to silver
-- Incremental Ingestion on 

USE DATABASE alpha_db;
USE SCHEMA silver;

CREATE OR REPLACE PROCEDURE sp_run_silver()
RETURNS STRING
LANGUAGE SQL
AS
$$
BEGIN
  -- cleaned_customers
  INSERT INTO cleaned_customers
  SELECT
      customer_id::INT,
      INITCAP(customer_name),
      LOWER(email),
      INITCAP(country)
  FROM bronze.stream_customers
  WHERE METADATA$ACTION = 'INSERT';

  -- cleaned_orders
  INSERT INTO cleaned_orders
  SELECT
      order_id::INT,
      customer_id::INT,
      order_date,
      INITCAP(payment_method)
  FROM bronze.stream_orders
  WHERE METADATA$ACTION = 'INSERT';

  -- cleaned_payments
  INSERT INTO cleaned_payments
  SELECT
      payment_id::INT,
      order_id::INT,
      TRY_CAST(amount AS FLOAT),
      INITCAP(payment_status)
  FROM bronze.stream_payments
  WHERE METADATA$ACTION = 'INSERT';

  -- enriched_order_items
  INSERT INTO enriched_order_items
  SELECT
      oi.order_item_id::INT,
      oi.order_id::INT,
      oi.product_id::INT,
      p.product_name,
      p.category,
      oi.quantity::INT,
      oi.unit_price::FLOAT,
      ROUND(oi.quantity * oi.unit_price, 2)
  FROM bronze.stream_order_items oi
  JOIN bronze.products p ON oi.product_id = p.product_id
  WHERE METADATA$ACTION = 'INSERT';

  -- order_summary
  INSERT INTO order_summary
  SELECT
      o.order_id,
      o.order_date,
      c.customer_id,
      c.customer_name,
      c.country,
      p.product_name,
      p.category,
      oi.quantity,
      oi.unit_price,
      ROUND(oi.quantity * oi.unit_price, 2) AS line_total,
      pay.amount AS payment_amount,
      pay.payment_status
  FROM silver.cleaned_orders o
  JOIN silver.cleaned_customers c ON o.customer_id = c.customer_id
  JOIN silver.enriched_order_items oi ON o.order_id = oi.order_id
  JOIN bronze.products p ON oi.product_id = p.product_id
  LEFT JOIN silver.cleaned_payments pay ON o.order_id = pay.order_id;

  RETURN '✅ Silver Layer Incremental Transformation Completed';
END;
$$;
