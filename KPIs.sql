#total sales and profit
select 
sum(sales) as total_sales,
sum(profit) as total_profit
from saas_table;

#Sales and Profit By Year
select
year,
sum(sales) as total_sales,
sum(profit) as total_profit
from saas_table
group by year
order by year;

#top 5 products by revenue
select product, 
sum(sales) as revenue
from saas_table
group by product
order by revenue desc 
limit 10;

#Profit margin by region
select region,
sum(profit)/sum(sales) * 100 as profit_margin
from saas_table
group by region;

#Categorize transactions by discount level
select
case
	when discount = 0 then 'No Discount'
    when discount <=0.30 then 'Low Discount'
    else 'High Discount'
end as discount_category,
sum(profit) as total_profit
from saas_table
group by discount_category;

#Products with above average Sales
select distinct product
from saas_table
where sales > (select avg(sales) from saas_table);

#Customers whose total spend is above company average
select customer, sum(sales) as total_spent
from saas_table
group by customer
having total_spent > (select avg(sales) from saas_table)
order by total_spent desc;

#Yearly revenue and YoY growth
WITH yearly_sales AS (
    SELECT 
        year,
        SUM(sales) AS revenue
    FROM saas_table
    GROUP BY year
)
SELECT
    year,
    revenue,
    revenue - LAG(revenue) OVER (ORDER BY year) AS yoy_growth
FROM yearly_sales;
