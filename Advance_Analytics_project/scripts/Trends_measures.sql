--Find the sales data months wise.
select 
	DATETRUNC(MONTH, order_date) as OrderDate,
	sum(sales_amount) as Total_sales
from gold.fact_sales
where order_date is not null
group by DATETRUNC(MONTH, order_date)
order by DATETRUNC(MONTH, order_date)