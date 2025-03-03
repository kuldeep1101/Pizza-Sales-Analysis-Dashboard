use Pizza

-- KPI 1. Total revenue
select round(SUM(total_price),3) as Total_Revenue from pizza_sales;

-- KPI 2. Average order value
select ROUND((SUM(total_price) / COUNT(Distinct order_id)),3) as Avg_Order_Sale from pizza_sales;

-- KPI 3. Total pizza sold
select SUM(quantity) as Total_Pizza_Sold from pizza_sales;

-- KPI 4. Total number of order placed
select COUNT(Distinct order_id) as Total_Order from pizza_sales;

-- KPI 5. Average pizza per order
select CAST((CAST(SUM(quantity) as decimal(10,3)) / CAST(COUNT(Distinct order_id) as decimal(10,3))) AS decimal(10,3)) as Avg_Pizza_per_Order from pizza_sales;





-- 1. Daily Trend for Total Orders
select DATENAME(dw,order_date) as "Day", 
		COUNT(Distinct order_id) as "Total_orders" 
from pizza_sales
group by DATENAME(dw,order_date);
/*
select order_date, SUM(Distinct order_id)
from pizza_sales
group by order_date
order by order_date
*/

-- 2. Hourly Trend for Total Orders
select DATEPART(HH,order_time) as order_hour,
		COUNT(Distinct order_id) as Total_hour
from pizza_sales
group by DATEPART(HH,order_time)
order by DATEPART(HH,order_time);
/*
select  order_time, SUM(Distinct order_id)
from pizza_sales
group by order_time
order by order_time
*/

-- 3. Percentage sale by Pizza category
select pizza_category,
		Round(100*(sum(total_price)/(select sum(total_price) from pizza_sales)), 3) as category_percentage
from pizza_sales
group by pizza_category
order by category_percentage desc;


-- 4. Percentage of sale by Pizza size
select pizza_size,
		Round(100*(sum(total_price)/(select sum(total_price) from pizza_sales)), 3) as size_percentage
from pizza_sales
group by pizza_size
order by size_percentage desc;

-- 5. Total pizza sold by category
select pizza_category, count(quantity) as Pizza_Count
from pizza_sales
group by pizza_category
order by Pizza_Count desc;


-- 6. Top 5 best seller by total pizza sold
select TOP 5 pizza_name, 
	sum(quantity) as total_quantity 
from pizza_sales
group by pizza_name
order by sum(quantity) desc;

-- 7. Bottom 5 worse seller by total pizza sold
select TOP 5 pizza_name, 
	sum(quantity) as total_quantity 
from pizza_sales
group by pizza_name
order by sum(quantity);