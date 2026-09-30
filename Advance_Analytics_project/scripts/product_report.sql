/*
=============================================================================
Product Report
=============================================================================
Purpose:
    - This report consolidates key product metrics and behaviors.

Highlights:
    1. Gathers essential fields such as product name, category, subcategory, and cost.
    2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
    3. Aggregates product-level metrics:
       - total orders
       - total sales
       - total quantity sold
       - total customers (unique)
       - lifespan (in months)
    4. Calculates valuable KPIs:
       - recency (months since last sale)
       - average order revenue (AOR)
       - average monthly revenue
=============================================================================
*/

--1. Gathers essential fields such as product name, category, subcategory, and cost.
create view  gold.product_report as 
with Base_query as (
select
    p.product_key,
    p.product_name,
    p.category,
    p.subcategory,
    p.cost,
    f.customer_key,
    f.order_number,
    f.order_date,
    f.quantity,
    f.sales_amount
from gold.dim_products p
left join gold.fact_sales f
on p.product_key = f.product_key)

/* 3. Aggregates product-level metrics:
       - total orders
       - total sales
       - total quantity sold
       - total customers (unique)
       - lifespan (in months) */
, product_aggregate as(
select
    product_key,
    product_name,
    category,
    subcategory,
    cost,
    COUNT(distinct order_number) as Total_order,
    sum(sales_amount) as Total_sales,
    sum(quantity) as Total_quantity,
    COUNT(distinct customer_key) as Total_cus,
    max(order_date) as last_order,
    DATEDIFF(MONTH, MIN(order_date), max(order_date)) as lifespan
from Base_query
group by product_key,
    product_name,
    category,
    subcategory,
    cost)

--2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
/* 4. Calculates valuable KPIs:
       - recency (months since last sale)
       - average order revenue (AOR)
       - average monthly revenue*/
select
    product_key,
    product_name,
    category,
    subcategory,
    cost,
    last_order,
    case
        when Total_sales  > 100000 then 'High-Performers'
        when Total_sales  >= 40000 then 'Mid-Range'
        else 'Low-Performers'
    end as products_segments,
    Total_sales,
    -- recency (months since last sale)
    DATEDIFF(MONTH, last_order , GETDATE()) as recency,
    -- average order revenue (AOR)
    (Total_sales / Total_order) as AOR,
    -- average monthly revenue
    Total_sales/lifespan as avg_monthly_revenue,
    Total_order,
    Total_quantity,
    Total_cus,
    lifespan
from product_aggregate
where Total_sales is not null