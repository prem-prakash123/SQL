## Silver Layer – Data Cleaning & Transformation

This stored procedure transforms and cleans raw data from the **Bronze Layer** and loads the processed data into the **Silver Layer**.

### CRM Tables

* **`silver.crm_customer_info`** – Removes duplicate customers, trims names, and converts marital status and gender codes into readable values.
* **`silver.crm_products_info`** – Extracts category IDs, handles missing product costs, standardizes product lines, and calculates product end dates using `LEAD()`.
* **`silver.crm_sales_details`** – Converts date values, handles invalid dates, validates sales and price values, and prevents division-by-zero errors.

### ERP Tables

* **`silver.erp_cust_az12`** – Cleans customer IDs, validates birth dates, and standardizes gender values.
* **`silver.erp_LOC_A101`** – Cleans customer IDs and converts country codes such as `DE`, `US`, and `USA` into full country names.
* **`silver.erp_PX_CAT_G1V2`** – Transfers product category, sub-category, and maintenance information into the Silver Layer.

### Purpose

The procedure uses **TRUNCATE, INSERT, CASE, TRIM, ISNULL, LEAD, ROW_NUMBER, and data validation techniques** to create clean, standardized, 
	and analysis-ready data for the next layer of the data warehouse.


create or alter procedure silver.load_silver as
Begin

--crm_customer_info
Truncate table silver.crm_customer_info
insert into silver.crm_customer_info(
    cst_id,
    cst_key,
    cst_firstname,
    cst_lastname,
    cst_marital_status,
    cst_gndr,
    cst_create_date)

select
    cst_id,
    cst_key,
    trim(cst_firstname) as cst_firstname,
    trim(cst_lastname) as cst_lastname,
    case when cst_marital_status = 'M' then 'Married'
         when cst_marital_status = 'S' then 'Single'
         else'n/a'
    end as cst_marital_status,
    case when cst_gndr = 'M' then 'Male'
         when cst_gndr = 'F' then 'Female'
         else'n/a'
    end as cst_gndr,
    cst_create_date
from(
select
    *,
    ROW_NUMBER() over (partition by cst_id order by cst_create_date desc) as flag_last
from bronze.crm_customer_info
)t where flag_last = 1

--crm_products_info
Truncate Table silver.crm_products_info
insert into silver.crm_products_info(
      prd_id,
      cat_id,
      prd_key,
      prd_name,
      prd_cost,
      prd_line,
      prd_start_dt,
      prd_end_dt)
select 
    prd_id,
    Replace(SUBSTRING(prd_key, 1,5), '-','_' ) as cat_id,
    SUBSTRING(prd_key, 7, LEN(prd_key)) as prd_key,

    prd_name,

    isnull(prd_cost, 0) as prd_cost,

    case when prd_line = 'R' then 'Road'
         when prd_line = 's' then 'Other Products'
         when prd_line = 'T' then 'Touring'
         when prd_line = 'M' then 'Moutains'
         else'n/a'
    end as prd_line,

    prd_start_dt,
    --prd_end_dt
    dateadd(
        day,
        -1,
        LEAD(prd_start_dt) over(
        partition by prd_key 
        order by prd_start_dt
    )) as prd_end_dt_test
from bronze.crm_products_info

--crm_sales_details
Truncate Table silver.crm_sales_details
insert into silver.crm_sales_details(
    sales_ord_num,
	sls_prd_key ,
	sls_cust_id,
	sls_order_dt,
	sls_ship_dt ,
	sls_due_dt,
	sls_sales ,
	sls_quantity,
	sls_price
)

select
      sales_ord_num,
      sls_prd_key,
      sls_cust_id,

      case 
          when sls_order_dt = 0 or LEN(sls_order_dt) !=8 then null
          else cast(cast(sls_order_dt as varchar)as date)
      end as sls_order_dt,

      case 
          when sls_ship_dt = 0 or LEN(sls_ship_dt) !=8 then null
          else cast(cast(sls_ship_dt as varchar) as date)
      end as sls_ship_dt,

      case 
          when sls_due_dt = 0 or LEN(sls_due_dt) !=8 then null
          else cast(cast(sls_due_dt as varchar) as date)
      end as sls_due_dt,

      case 
          when sls_sales is null or sls_sales <0 or sls_sales != sls_quantity * abs(sls_price)
          then sls_quantity * abs(sls_price)
          else sls_sales
      end as sls_sales,

      sls_quantity,

      case 
          when sls_price is null or sls_price <0 
          then sls_sales / nullif(sls_quantity,0)
          else sls_price
      end as sls_price
from bronze.crm_sales_details

--erp_cust_az12
Truncate table silver.erp_cust_az12
insert into silver.erp_cust_az12(
cid,
DOB,
gender
)
select
    case 
        when cid like 'NAS%' then SUBSTRING(cid, 4, LEN(cid)) 
        else cid
    end as cid,

    case 
        when DOB > GETDATE () then null
        else DOB
    end as DOB,

    case 
         when upper(Trim(gender)) in ('F','Female') then 'Female'
         when upper(Trim(gender)) in ('M', 'Male') then 'Male'
         else 'n/a'
    end as gender
from bronze.erp_cust_az12

--erp_LOC_A101
Truncate Table silver.erp_LOC_A101O
insert into silver.erp_LOC_A101(
cid,
Country
)
select
	replace(CID, '-', '') as cid,

	case 
		when Country = 'DE' then 'Germany'
		when Country in ('US' , 'USA') then 'United States'
		when Country = '' or Country is NULL then 'n/a'
		else Country
	end as country
from bronze.erp_LOC_A101

--erp_PX_CAT_G1V2
truncate table silver.erp_PX_CAT_G1V2
insert into silver.erp_PX_CAT_G1V2(
    id,
	Category,
	Sub_Category,
	Maintenance
)
select
	id,
	Category,
	Sub_Category,
	Maintenance
from bronze.erp_PX_CAT_G1V2
end
