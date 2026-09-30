/* Analyze the yearly performance of products by comparing their sales
to both the average sales performance of the product and the previous year's sales */
With Yearly_products_sales as(
select
	p.product_name,
	year(order_date) order_year,
	sum(sales_amount) as current_sales
from gold.fact_sales f
left join gold.dim_products p
on f.product_key = p.product_key
where f.order_date is not null
group by 
	year(order_date),
	p.product_name
)
select
	product_name,
	order_year,
	current_sales,
	AVG(current_sales) over(partition by product_name) as avg_sales,
	current_sales - AVG(current_sales) over(partition by product_name) as diff_avg,
	case 
		when current_sales - AVG(current_sales) over(partition by product_name) > 0 then 'Above Avg'
		when current_sales - AVG(current_sales) over(partition by product_name) < 0 then 'Below Avg'
		else 'Avg'
	end avg_change,
	LAG(current_sales) over(partition by product_name order by order_year) as py_sales,
	current_sales - LAG(current_sales) over(partition by product_name order by order_year) as py_diff,
	case 
		when current_sales - LAG(current_sales) over(partition by product_name order by order_year) > 0 then 'Increase'
		when current_sales - LAG(current_sales) over(partition by product_name order by order_year) < 0 then 'Decrease'
		else 'No change'
	end py_change
from Yearly_products_sales
order by  
	product_name, 
	order_year