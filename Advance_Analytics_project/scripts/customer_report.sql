/*
=============================================================
Customer Report
=============================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
    2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
       - total orders
       - total sales
       - total quantity purchased
       - total products
       - lifespan (in months)
    4. Calculates valuable KPIs:
       - recency (months since last order)
       - average order value
       - average monthly spend
=============================================================
*/
create view gold.report_customer as
--1. Gathers essential fields such as names, ages, and transaction details.
with Base_query as (
select
    f.order_number,
    f.product_key,
    f.order_date,
    f.sales_amount,
    f.quantity,
    c.customer_key,
    c.customer_number,
    CONCAT(c.first_name, ' ' , c.last_name ) as Cus_name,
    DATEDIFF(YEAR,c.birthdate, GETDATE()) as Age
from gold.fact_sales f
left join gold.dim_customers c
on f.customer_key = c.customer_key
where order_date is not null)

/*3. Aggregates customer-level metrics:
       - total orders
       - total sales
       - total quantity purchased
       - total products
       - lifespan (in months)*/

, customer_aggregation as (
select
    customer_key,
    customer_number,
    Cus_name,
    Age,
    MAX(order_date) as Last_order_date,
    COUNT(distinct order_number) as total_orders,
    SUM(quantity) as total_quantity,
    COUNT(distinct product_key) as total_products,
    SUM(sales_amount) as total_sales,
    DATEDIFF(MONTH, min(order_date), MAX(order_date)) as lifespan
from Base_query
group by
    customer_key,
    customer_number,
    Cus_name,
    Age
)

--2. Segments customers into categories (VIP, Regular, New) and age groups.
select
    customer_key,
    customer_number,
    Cus_name,
    Age,
    case 
        when age > 60 then '60 and Above'
        when age between 40 and 60 then '40-60'
        when age between 30 and 40 then '30-40'
        else 'child'
    end Age_group,
    case
        when lifespan > 24 and total_sales > 5000 then 'VIP'
        when lifespan > 24 and total_sales <= 5000 then 'Regular'
        else 'New'
    end as cus_segment,
    Last_order_date,
    --recency (months since last order)
    DATEDIFF(MONTH, Last_order_date, GETDATE()) as Recency,
    total_orders,
    total_quantity,
    total_products,
    total_sales,
    lifespan,
    --average order value
    case
        when total_sales = 0 then 0
        else (total_sales / total_orders)
    end as avg_order_value,
    --average monthly spend
    case
        when lifespan = 0 then 0
        else (total_sales / lifespan)
    end  as Avg_monthly_spend
from customer_aggregation
where Age is not null
