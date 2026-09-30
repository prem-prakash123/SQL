/* segment products into cost ranges and
count how any products fall into each segement */
with products_segment as(
select 
    product_key,
	product_name,
	cost,
	case 
		when cost <500 then 'Below 500'
		when cost between 500 and 1000 then '500 - 1000'
		when cost between 1000 and 1500 then '1000 - 1500'
		else'Above 1500'
	end as cost_range
from gold.dim_products)

select
cost_range,
count(product_key) as Total_products
from products_segment
group by cost_range
order by Total_products desc