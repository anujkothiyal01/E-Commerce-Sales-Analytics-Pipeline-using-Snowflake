-- before running do config DESC INTEGRATION ecommerce_s3_integration; and copy paste USER_ARN, EXTERNAL_ID to Trust Policy of IAM Role

USE DATABASE alpha_db;

USE SCHEMA bronze;

-- Stage
CREATE OR REPLACE STAGE s3_stage_customers
URL = 's3://pipeline-alpha-bucket/customers/'
STORAGE_INTEGRATION = ecommerce_s3_integration
FILE_FORMAT = ecommerce_csv_format;

CREATE OR REPLACE STAGE s3_stage_order_items
URL = 's3://pipeline-alpha-bucket/order_items/'
STORAGE_INTEGRATION = ecommerce_s3_integration
FILE_FORMAT = ecommerce_csv_format;

CREATE OR REPLACE STAGE s3_stage_orders
URL = 's3://pipeline-alpha-bucket/orders/'
STORAGE_INTEGRATION = ecommerce_s3_integration
FILE_FORMAT = ecommerce_csv_format;

CREATE OR REPLACE STAGE s3_stage_payments
URL = 's3://pipeline-alpha-bucket/payments/'
STORAGE_INTEGRATION = ecommerce_s3_integration
FILE_FORMAT = ecommerce_csv_format;

CREATE OR REPLACE STAGE s3_stage_products
URL = 's3://pipeline-alpha-bucket/products/'
STORAGE_INTEGRATION = ecommerce_s3_integration
FILE_FORMAT = ecommerce_csv_format;

-- Create Pipe
CREATE OR REPLACE PIPE pipe_customers
AUTO_INGEST = TRUE
AS
COPY INTO customers
FROM @s3_stage_customers
FILE_FORMAT = (FORMAT_NAME = ecommerce_csv_format),
ON_ERROR = 'CONTINUE';

CREATE OR REPLACE PIPE pipe_order_items
AUTO_INGEST = TRUE
AS
COPY INTO order_items
FROM @s3_stage_order_items
FILE_FORMAT = (FORMAT_NAME = ecommerce_csv_format),
ON_ERROR = 'CONTINUE';

CREATE OR REPLACE PIPE pipe_orders
AUTO_INGEST = TRUE
AS
COPY INTO orders
FROM @s3_stage_orders
FILE_FORMAT = (FORMAT_NAME = ecommerce_csv_format),
ON_ERROR = 'CONTINUE';

CREATE OR REPLACE PIPE pipe_payments
AUTO_INGEST = TRUE
AS
COPY INTO payments
FROM @s3_stage_payments
FILE_FORMAT = (FORMAT_NAME = ecommerce_csv_format),
ON_ERROR = 'CONTINUE';

CREATE OR REPLACE PIPE pipe_products
AUTO_INGEST = TRUE
AS
COPY INTO products
FROM @s3_stage_products
FILE_FORMAT = (FORMAT_NAME = ecommerce_csv_format),
ON_ERROR = 'CONTINUE';