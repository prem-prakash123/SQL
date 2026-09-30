# Data Warehousing & Analytics Project

## 📌 Overview

This project demonstrates the development of a **Data Warehouse and Analytics solution using SQL Server**. The project follows a **Medallion Architecture** with Bronze, Silver, and Gold layers to transform raw data into business-ready information for analysis and reporting.

## 🎯 Project Objectives

- Build a structured data warehouse using SQL Server.
- Load and transform data from multiple source systems.
- Clean and standardize raw data.
- Create business-ready dimension and fact views.
- Develop a foundation for analytics and reporting.
- Practice SQL, data cleaning, transformation, and data modeling concepts.

## 🏗️ Data Architecture

<img width="877" height="531" alt="data_architecture" src="https://github.com/user-attachments/assets/d84344cd-ab69-4144-ae32-7cd2afcc7699" />


The project uses three main layers:

```
Source Systems
     │
     ▼
┌─────────────┐
│ Bronze Layer│
│ Raw Data    │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│ Silver Layer│
│ Cleaned Data│
└──────┬──────┘
       │
       ▼
┌─────────────┐
│  Gold Layer │
│ Business    │
│ Ready Data  │
└──────┬──────┘
       │
       ▼
 Analytics & Reporting
```

### 🥉 Bronze Layer

The Bronze Layer stores data in its raw form with minimal transformation.

**Main activities:**

- Load data from source CSV files.
- Store raw CRM and ERP data.
- Maintain the original source structure.

### 🥈 Silver Layer

The Silver Layer contains cleaned and standardized data.

**Main activities:**

- Data cleaning
- Data validation
- Standardization
- Handling missing and inconsistent values
- Data transformation

### 🥇 Gold Layer

The Gold Layer contains business-ready data designed for analytics.

**Dimension Views:**

- `gold.dim_customers`
- `gold.dim_products`

**Fact View:**

- `gold.fact_sales_details`

## 🛠️ Technologies Used

- **SQL Server**
- **T-SQL**
- **SQL Server Management Studio (SSMS)**
- **Git & GitHub**
- **CSV Files**

## 📂 Project Structure

```
Data-Warehousing-Analytics-Project/
│
├── datasets/
│   └── source data
│
├── scripts/
│   ├── bronze/
│   │   └── Bronze Layer SQL scripts
│   │
│   ├── silver/
│   │   └── Silver Layer SQL scripts
│   │
│   └── gold/
│       └── Gold Layer SQL scripts
│
├── docs/
│   └── Project documentation
│
└── README.md
```

## ⭐ Key Features

- Three-layer data warehouse architecture
- SQL-based ETL/ELT transformations
- Data cleaning and standardization
- Customer and product dimensions
- Sales fact table/view
- Surrogate keys using `ROW_NUMBER()`
- Integration of CRM and ERP data
- Business-ready data model for analytics

## 📊 Gold Layer Data Model

Data model

<img width="1288" height="490" alt="data_model" src="https://github.com/user-attachments/assets/3b84c5d0-1ab8-4dfd-b0cf-b66d6cb79269" />


The Gold Layer follows a simple **Star Schema** approach.

```
             ┌──────────────────┐
             │  dim_customers   │
             │──────────────────│
             │ customer_key     │
             │ customer_id      │
             │ customer_number  │
             │ first_name       │
             │ last_name        │
             │ gender           │
             │ birthdate        │
             └────────┬─────────┘
                      │
                      │
                      ▼
             ┌──────────────────┐
             │ fact_sales       │
             │──────────────────│
             │ order_number     │
             │ product_key      │
             │ customer_key     │
             │ order_date       │
             │ shipping_date    │
             │ sales            │
             │ quantity         │
             │ price            │
             └────────┬─────────┘
                      │
                      │
                      ▼
             ┌──────────────────┐
             │  dim_products    │
             │──────────────────│
             │ product_key      │
             │ product_id       │
             │ product_number   │
             │ product_name     │
             │ category         │
             │ subcategory      │
             │ product_cost     │
             └──────────────────┘
```

## 🚀 Project Workflow

1. Collect source data from CRM and ERP systems.
2. Load raw data into the Bronze Layer.
3. Clean and transform data in the Silver Layer.
4. Integrate related CRM and ERP datasets.
5. Create business-ready dimensions and facts in the Gold Layer.
6. Use the Gold Layer for analytics and reporting.

## 📚 Skills Demonstrated

- SQL Server
- T-SQL
- Data Warehousing
- ETL / ELT
- Data Cleaning
- Data Transformation
- Joins
- CTEs
- Window Functions
- Views
- Data Modeling
- Star Schema
- Git & GitHub

## 👨‍💻 Author

**Prem Prakash**

Aspiring Data Analyst | SQL | Power BI | Excel | Python

---

⭐ This project was created for learning and demonstrating practical **Data Warehousing and Analytics** skills.
