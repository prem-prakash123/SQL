Create or alter procedure bronze.load_bronze as
begin

	Truncate table bronze.crm_customer_info
	Bulk insert bronze.crm_customer_info
	from 'C:\Users\prem prakash\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
	with(
	firstrow =2,
	fieldterminator = ',',
	tablock
	);

	Truncate table bronze.crm_products_info
	Bulk insert bronze.crm_products_info
	from 'C:\Users\prem prakash\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
	with(
	firstrow =2,
	fieldterminator = ',',
	tablock
	);

	Truncate table bronze.crm_sales_details
	Bulk insert bronze.crm_sales_details
	from 'C:\Users\prem prakash\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
	with(
	firstrow =2,
	fieldterminator = ',',
	tablock
	);

	Truncate table bronze.erp_cust_az12
	Bulk insert bronze.erp_cust_az12
	from 'C:\Users\prem prakash\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
	with(
	firstrow =2,
	fieldterminator = ',',
	tablock
	);

	Truncate table bronze.erp_LOC_A101
	Bulk insert bronze.erp_LOC_A101
	from 'C:\Users\prem prakash\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
	with(
	firstrow =2,
	fieldterminator = ',',
	tablock
	);

	Truncate table bronze.erp_PX_CAT_G1V2
	Bulk insert bronze.erp_PX_CAT_G1V2
	from 'C:\Users\prem prakash\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
	with(
	firstrow =2,
	fieldterminator = ',',
	tablock
	);
end