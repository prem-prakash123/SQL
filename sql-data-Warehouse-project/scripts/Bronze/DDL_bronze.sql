if OBJECT_ID ('bronze.crm_customer_info', 'U') is not null
   drop table bronze.crm_customer_info;
Create Table bronze.crm_customer_info(
	cst_id Int,
	cst_key nvarchar(50),
	cst_firstname nvarchar(50),
	cst_lastname nvarchar(50),
	cst_marital_status nvarchar(50),
	cst_gndr nvarchar(50),
	cst_create_date date
);

if OBJECT_ID ('bronze.crm_products_info', 'U') is not null
   drop table bronze.crm_products_info;
Create Table bronze.crm_products_info(
	prd_id int,
	prd_key nvarchar(50),
	prd_name nvarchar(50),
	prd_cost int,
	prd_line char(50),
	prd_start_dt date,
	prd_end_dt date
);

if OBJECT_ID ('bronze.crm_sales_details', 'U') is not null
   drop table bronze.crm_sales_details;
Create Table bronze.crm_sales_details(
	sales_ord_num varchar(50),
	sls_prd_key varchar(30),
	sls_cust_id int,
	sls_order_dt int,
	sls_ship_dt int,
	sls_due_dt int,
	sls_sales int,
	sls_quantity int,
	sls_price int
);

if OBJECT_ID ('bronze.erp_cust_az12', 'U') is not null
   drop table bronze.erp_cust_az12;
Create Table bronze.erp_cust_az12(
	cid varchar(50),
	DOB date,
	gender char(10)
);

if OBJECT_ID ('bronze.erp_LOC_A101', 'U') is not null
   drop table bronze.erp_LOC_A101;
Create Table bronze.erp_LOC_A101(
	CID varchar(20),
	Country Char(20)
);

if OBJECT_ID ('bronze.erp_PX_CAT_G1V2', 'U') is not null
   drop table bronze.erp_PX_CAT_G1V2;
Create Table bronze.erp_PX_CAT_G1V2(
	Id varchar(10),
	Category char(20),
	Sub_Category char(20),
	Maintenance char(10)
)
