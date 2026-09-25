## Silver Layer – Table Creation

This SQL script creates the **Silver Layer tables** in the data warehouse. It:

* Creates structured tables for CRM and ERP data.
* Drops existing tables before recreating them.
* Defines appropriate data types for each column.
* Adds `dwh_create_date` to track data load time.
* Prepares the cleaned data layer for further transformation and analysis.

  
if OBJECT_ID ('silver.crm_customer_info', 'U') is not null
   drop table silver.crm_customer_info;
Create Table silver.crm_customer_info(
	cst_id Int,
	cst_key nvarchar(50),
	cst_firstname nvarchar(50),
	cst_lastname nvarchar(50),
	cst_marital_status nvarchar(50),
	cst_gndr nvarchar(50),
	cst_create_date date,
	dwh_create_date datetime2 default getdate()
);

if OBJECT_ID ('silver.crm_products_info', 'U') is not null
   drop table silver.crm_products_info;
Create Table silver.crm_products_info(
	prd_id int,
	cat_id nvarchar(10),
	prd_key nvarchar(50),
	prd_name nvarchar(50),
	prd_cost int,
	prd_line char(50),
	prd_start_dt date,
	prd_end_dt date,
	dwh_create_date datetime2 default getdate()
);

if OBJECT_ID ('silver.crm_sales_details', 'U') is not null
   drop table silver.crm_sales_details;
Create Table silver.crm_sales_details(
	sales_ord_num varchar(50),
	sls_prd_key varchar(30),
	sls_cust_id int,
	sls_order_dt date,
	sls_ship_dt date,
	sls_due_dt date,
	sls_sales int,
	sls_quantity int,
	sls_price int,
	dwh_create_date datetime2 default getdate()
);

if OBJECT_ID ('silver.erp_cust_az12', 'U') is not null
   drop table silver.erp_cust_az12;
Create Table silver.erp_cust_az12(
	cid varchar(50),
	DOB date,
	gender char(10),
	dwh_create_date datetime2 default getdate()
);

if OBJECT_ID ('silver.erp_LOC_A101', 'U') is not null
   drop table silver.erp_LOC_A101;
Create Table silver.erp_LOC_A101(
	CID varchar(20),
	Country Char(20),
	dwh_create_date datetime2 default getdate()
);

if OBJECT_ID ('silver.erp_PX_CAT_G1V2', 'U') is not null
   drop table silver.erp_PX_CAT_G1V2;
Create Table silver.erp_PX_CAT_G1V2(
	Id varchar(10),
	Category char(20),
	Sub_Category char(20),
	Maintenance char(10),
	dwh_create_date datetime2 default getdate()
)

