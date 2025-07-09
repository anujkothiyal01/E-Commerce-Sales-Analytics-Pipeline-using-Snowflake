# 🧊 E-Commerce Sales Analytics Pipeline using Snowflake

This project is a full-fledged ELT pipeline built on **Snowflake**, designed to process e-commerce sales data from raw S3 files through Bronze, Silver, and Gold layers — following modern data engineering best practices.

## Architecture

![image](https://github.com/user-attachments/assets/4ddacc03-380c-447a-93a1-a6fb7286cf77)

![image](https://github.com/user-attachments/assets/48253309-65c5-4220-86f6-e4e33ed9d149)

---

## 🛠️ Tech Stack

- **Snowflake** (Data Warehouse)
- **AWS S3** (Raw Data Storage)
- **Snowpipe** (Continuous data ingestion)
- **Streams & Tasks** (Incremental loading & scheduling)
- **SQL Stored Procedures** (Reusable logic layers)

---

## 🧪 What This Project Does

1. Ingests raw CSV data from Amazon S3 into Snowflake via Snowpipe
2. Cleans and transforms the data through Bronze → Silver → Gold layers
3. Automates incremental updates using **Streams** and **Tasks**
4. Generates customer-level metrics like **total orders, total spend**, and **customer type**

---

## 📂 Data Architecture

### 🟤 Bronze Layer
- Ingests raw CSV files into external stages and loads into staging tables
- Uses **Snowpipe** with SQS event notification to auto-ingest data on arrival
- Example: `bronze.customers`, `bronze.orders`, etc.

### 🟠 Silver Layer
- Applies cleaning and normalization logic
- Uses **Streams** on bronze tables and a stored procedure `sp_run_silver()`
- Automates transformation using a **scheduled Task** that runs every 1 minute
- Output: `silver.cleaned_customers`, `silver.cleaned_orders`, etc.

### 🟡 Gold Layer
- Aggregates data for analytics and reporting
- Created as a materialized **table** via `sp_run_gold()` procedure
- Optional: Can be automated using a chained Task (`AFTER task_stream_has_data`)
- Output: `gold.customer_order_stats`

---

## 🧰 Components Walkthrough

![image](https://github.com/user-attachments/assets/3a4d1163-97d8-417a-8fb6-b87c336557b1)


### ✅ 1. 📂 one_time_setup/
This folder contains one-time initialization scripts for setting up a Snowflake-based ELT pipeline with S3 as the data source and a multi-layer architecture: Bronze → Silver → Gold.

#### setup.sql
🧩 Purpose: Initializes the Snowflake environment for the ELT pipeline
✅ Actions:
* Creates the project database: alpha_db
* Sets up three schemas for the layered architecture: bronze, silver, and gold
* Defines raw data tables in the bronze schema:
* customers, orders, order_items, payments, products
* Creates a reusable CSV FILE FORMAT for ingesting data from S3
* Establishes a secure STORAGE INTEGRATION with AWS using IAM role access

#### storage_integration_setup.sql
🧩 Purpose: Establishes secure data ingestion from S3 to Snowflake's Bronze layer
✅ Actions:
* Uses the previously created STORAGE INTEGRATION (ecommerce_s3_integration) to securely access S3 data
* Creates external stages for each raw data folder in S3:
  - s3_stage_customers, s3_stage_order_items, s3_stage_orders, s3_stage_payments, s3_stage_products
* Defines Snowpipes with AUTO_INGEST = TRUE to automatically load new S3 files into Bronze tables
* Each pipe targets a corresponding table in the Bronze schema (customers, orders, etc.)
* Uses ON_ERROR = 'CONTINUE' to skip corrupt rows and ensure ingestion continuity

#### stream_bronze_to_silver.sql
🧩 Purpose: Tracks new data in Bronze tables for incremental processing
✅ Actions:
* Creates Streams on Bronze tables to capture INSERT operations
* Enables change data capture (CDC) for:
  - customers, orders, payments, order_items, products
* Used in the Silver-layer procedure for incremental loading.

#### test_stream_has_data.sql
🧩 Purpose: Validates if the stream has captured new data
✅ Actions:
* Queries stream_customers to inspect incoming records from S3
* Helps verify if Snowpipe ingestion and stream capture are working correctly

#### stream_silver_to_gold.sql
🧩 Purpose: Enables incremental loading from Silver to Gold layer
✅ Actions:
* Creates Streams on Silver tables to capture INSERT operations
* Streams created on:
* customers, orders, payments, order_items, products
* Used for building Gold aggregations incrementally.


---

### ✅ 2. 📂 bronze/

![image](https://github.com/user-attachments/assets/3df4d473-05a4-4aac-bd48-6909f25256ad)

#### test_customers_table.sql
🧩 Purpose: Validates raw customer data in the Bronze layer
✅ Actions:
* Runs a simple SELECT * FROM customers in the bronze schema
* Verifies that data ingestion via Snowpipe was successful

---

## 🧠 Key Concepts Learned
Real-time ingestion with Snowpipe + SQS

Incremental ELT using Streams + Tasks

End-to-end automation via stored procedures

Monitoring via TASK_HISTORY() and CLI

Python integration for advanced control

---

## 👨‍💻 Author

Made with ❤️ by Anuj Kothiyal
Cloud & Data Engineering Enthusiast

