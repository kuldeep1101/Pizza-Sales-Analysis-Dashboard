# Pizza-Sales-Analysis-Dashboard
## 1. Overview
The Pizza Sales Analysis Dashboard is an Excel-based analytical tool designed to evaluate sales trends, customer preferences, and business performance for a pizza restaurant. It leverages raw sales data to generate insightful visualizations and key performance indicators (KPIs), aiding decision-making in optimizing product offerings and sales strategies.

## 2. Objectives

- Identify total revenue, total orders, and total pizzas sold.
- Analyze sales trends by day and hour to find peak order times.
- Determine best-selling and worst-selling pizzas.
- Evaluate sales distribution across pizza categories and sizes.
- Provide actionable insights for menu optimization and business growth.

## 3. Data Sources
The project is based on a structured dataset stored in a pizza_sales table. The raw data consists of multiple fields, including:

-  order_id (Unique ID for each order)
-  order_date (Date of order placement)
-  order_time (Time of order placement)
-  pizza_name (Name of the pizza sold)
-  pizza_category (Category: Classic, Supreme, Veggie, Chicken, etc.)
-  pizza_size (Size: Small, Medium, Large, etc.)
-  quantity (Number of pizzas sold per order)
-  total_price (Revenue from each order)

## 4. Key Performance Indicators (KPIs)
The following KPIs were calculated to analyze sales performance:
### 4.1 Total Revenue
Query:
```
SELECT ROUND(SUM(total_price),3) AS Total_Revenue FROM pizza_sales;
```
This metric represents the total income generated from pizza sales.

### 4.2 Average Order Value (AOV)
Query:
```
SELECT ROUND((SUM(total_price) / COUNT(DISTINCT order_id)),3) AS Avg_Order_Sale FROM pizza_sales;
```
This helps assess the average revenue per order, indicating customer spending behavior.

### 4.3 Total Pizzas Sold
Query:
```
SELECT SUM(quantity) AS Total_Pizza_Sold FROM pizza_sales;
```
This shows the total number of pizzas sold during the analysis period.

### 4.4 Total Orders Placed
Query:
```
SELECT COUNT(DISTINCT order_id) AS Total_Order FROM pizza_sales;
```
This measures the total number of unique orders.

### 4.5 Average Pizzas Per Order
Query:
```
SELECT CAST((CAST(SUM(quantity) AS DECIMAL(10,3))
            / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,3))) AS DECIMAL(10,3)) AS Avg_Pizza_per_Order
FROM pizza_sales;
```
This metric provides insight into customer purchasing patterns.

## 5. Sales Trends & Analysis
### 5.1 Daily Sales Trends (Busiest Day)
Query:
```
SELECT DATENAME(dw, order_date) AS "Day",
        COUNT(DISTINCT order_id) AS "Total_orders"
FROM pizza_sales
GROUP BY DATENAME(dw, order_date);
```
Finding:
- **Friday** had the highest number of orders, indicating peak customer demand.

### 5.2 Hourly Sales Trends (Peak Order Times)
Query:
```
SELECT DATEPART(HH, order_time) AS order_hour,
        COUNT(DISTINCT order_id) AS Total_hour
FROM pizza_sales
GROUP BY DATEPART(HH, order_time)
ORDER BY DATEPART(HH, order_time);
```
Finding:
- The **busiest** time slots were **12:00–1:00 PM** and **5:00–8:00 PM**, aligning with lunch and dinner rush hours.

## 6. Sales Distribution by Category & Size
### 6.1 Percentage of Sales by Pizza Category
Query:
```
SELECT pizza_category,
        ROUND(100*(SUM(total_price)
                    / (SELECT SUM(total_price) FROM pizza_sales)), 3) AS category_percentage
FROM pizza_sales
GROUP BY pizza_category
ORDER BY category_percentage DESC;
```
Finding:
- The **Classic** category contributed the highest sales revenue.

### 6.2 Percentage of Sales by Pizza Size
Query:
```
SELECT pizza_size,
        ROUND(100*(SUM(total_price)
                    / (SELECT SUM(total_price) FROM pizza_sales)), 3) AS size_percentage
FROM pizza_sales
GROUP BY pizza_size
ORDER BY size_percentage DESC;
```
Finding:
- **Large-sized** pizzas generated the most revenue, indicating a preference for bigger portions.

## 7. Best & Worst Selling Pizzas
### 7.1 Top 5 Best-Selling Pizzas
Query:
```
SELECT TOP 5 pizza_name,
        SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity) DESC;
```
Finding:
- The **Classic Deluxe Pizza** and **Barbecue Chicken Pizza** were the best sellers.

### 7.2 Bottom 5 Worst-Selling Pizzas
Query:
```
SELECT TOP 5 pizza_name,
        SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity);
```
Finding:
- The **Brie Carre Pizza** had the lowest sales, indicating low customer preference.

## 8. Data Visualization (Excel Dashboard)
The Excel dashboard was built using pivot tables, charts, and slicers for interactive analysis. It includes:

- KPI summary cards for total revenue, orders, and pizzas sold.
- Line charts for daily and hourly sales trends.
- Pie charts for sales percentage by category and size.
- Bar charts for best and worst-selling pizzas.
- Filters to analyze sales data by date range.

![image](https://github.com/user-attachments/assets/b2d5c4cc-79e8-4848-aaab-9d7d61f070b0)


## 9. Insights & Business Recommendations
- Marketing Strategy: Focus promotional campaigns on Fridays and peak hours to maximize revenue.
- Menu Optimization: Consider removing or repositioning low-performing pizzas like Brie Carre Pizza.
- Size Preference: Offer discounts on large-sized pizzas to maintain high sales.
- Product Mix: Leverage the success of Classic Deluxe and Barbecue Chicken Pizzas by introducing similar varieties.

## 10. Conclusion
This project successfully analyzed pizza sales data, providing meaningful insights through an interactive Excel dashboard. The SQL queries validated the accuracy of key metrics, ensuring data integrity. These findings can help businesses make data-driven decisions to enhance sales performance and customer satisfaction.
