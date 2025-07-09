# 🧊 E-Commerce Sales Analytics Pipeline using Snowflake

This project is a full-fledged ELT pipeline built on **Snowflake**, designed to process e-commerce sales data from raw S3 files through Bronze, Silver, and Gold layers — following modern data engineering best practices.

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

### ✅ 1. Storage Integration + Stages
