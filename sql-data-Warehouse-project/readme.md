# Data Warehousing & Analytics Project

## 📌 Project Overview

This project demonstrates an end-to-end **Data Warehousing and Analytics solution using SQL Server**.

The project follows a **Bronze → Silver → Gold** architecture to transform raw data into clean, structured, and business-ready data for analytics.

---

## 🎯 Objectives

- Build a SQL Server Data Warehouse
- Load data from source files
- Clean and transform raw data
- Apply data quality checks
- Create Fact and Dimension tables
- Build a Star Schema
- Perform SQL-based analysis
- Generate business-ready insights

---

## 🛠️ Technologies Used

- **SQL Server**
- **T-SQL**
- **SQL Server Management Studio (SSMS)**
- **Excel / CSV**
- **Power BI**
- **Git & GitHub**

---

## 📋 Requirements

### Software

- SQL Server
- SQL Server Management Studio (SSMS)
- Git
- GitHub
- Power BI Desktop *(optional)*

### SQL Knowledge

- SELECT, WHERE, GROUP BY, HAVING
- Joins
- Aggregate Functions
- CTEs
- Window Functions
- Views
- Stored Procedures
- DDL & DML
- Data Cleaning
- Data Modeling

---

## 🏗️ Data Warehouse Architecture

```text
Source Data
     ↓
Bronze Layer
     ↓
Silver Layer
     ↓
Gold Layer
     ↓
Analytics & Reporting


📁 Project Structure
data-warehouse-project/
│
├── datasets/                           # Raw datasets used for the project (ERP and CRM data)
│
├── docs/                               # Project documentation and architecture details
│   ├── data_architecture.drawio        # Draw.io file shows the project's architecture
│
├── scripts/                            # SQL scripts for ETL and transformations
│   ├── bronze/                         # Scripts for extracting and loading raw data
│   ├── silver/                         # Scripts for cleaning and transforming data
│   ├── gold/                           # Scripts for creating analytical models
│
├── tests/                              # Test scripts and quality files
│
├── README.md                           # Project overview and instructions
├── LICENSE                             # License information for the repository
├── .gitignore                          # Files and directories to be ignored by Git
└── requirements.txt                    # Dependencies and requirements for the project
