--Calculate the total sales per months
--and running total of sales over time
select
	order_date,
	Total_sales,
	sum(Total_sales) over(order by order_date) as running_total_sales
from (
select 
	DATETRUNC(MONTH, order_date) as order_date,
	sum(sales_amount) as Total_sales
from gold.fact_sales
where order_date is not null
group by DATETRUNC(MONTH, order_date)
)t