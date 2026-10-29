-- =====================================================
-- SALES DATA ANALYSIS (table name: sales)
-- =====================================================

-- QUERY 1: Business overview
-- Shows total orders, unique customers, total revenue and average order value
SELECT COUNT(*) AS total_orders,                     -- every row = 1 order
       COUNT(DISTINCT CID) AS unique_customers,      -- each customer counted once
       ROUND(SUM(Net_Amount),0) AS total_revenue,    -- total money earned
       ROUND(AVG(Net_Amount),0) AS avg_order_value  -- average spend per order
FROM sales;


-- QUERY 2: Revenue by product category
-- Which product category earns the most?
SELECT Product_Category, COUNT(*) AS orders, ROUND(SUM(Net_Amount),0) AS revenue
FROM sales
GROUP BY Product_Category      -- one bucket per category
ORDER BY revenue DESC;         -- biggest firstsales


-- QUERY 3: Yearly sales trend
-- Is the business growing year by year?
-- Note: first and last years may be partial years
SELECT Year, COUNT(*) AS orders, ROUND(SUM(Net_Amount),0) AS revenue
FROM sales
GROUP BY Year                  -- one bucket per year
ORDER BY Year;                 -- oldest to newest


-- QUERY 4: Top 5 cities by revenue
-- Where should the business focus?
SELECT Location, ROUND(SUM(Net_Amount),0) AS revenue
FROM sales
GROUP BY Location              -- one bucket per city
ORDER BY revenue DESC
LIMIT 5;                       -- keep only the top 5


-- QUERY 5: Discount vs no discount
-- Do discounted orders have a higher average spend?
SELECT Discount_Availed, COUNT(*) AS orders,
       ROUND(AVG(Net_Amount),0) AS avg_order_value
FROM sales
GROUP BY Discount_Availed;     -- two buckets: Yes and No


-- QUERY 6: Which discount code costs the most?
-- Excludes orders that had no discount
SELECT Discount_Name, COUNT(*) AS times_used,
       ROUND(SUM(Discount_Amount),0) AS total_discount_given
FROM sales
WHERE Discount_Name <> 'No Discount'   -- <> means "not equal to"
GROUP BY Discount_Name
ORDER BY total_discount_given DESC;


-- QUERY 7: Most popular payment methods
-- How do customers prefer to pay?
SELECT Payment_Category, COUNT(*) AS orders, ROUND(SUM(Net_Amount),0) AS revenue
FROM sales
GROUP BY Payment_Category
ORDER BY orders DESC;


-- QUERY 8: Top 10 customers
-- Who are the VIP customers?
SELECT CID, COUNT(*) AS orders, ROUND(SUM(Net_Amount),0) AS total_spent
FROM sales
GROUP BY CID                   -- combines all rows of the same customer
ORDER BY total_spent DESC
LIMIT 10;

--Extra Queries
-- QUERY 9: Revenue by age group
-- Which age group spends the most?
SELECT Age_Group, ROUND(SUM(Net_Amount),0) AS revenue
FROM sales
GROUP BY Age_Group
ORDER BY revenue DESC;


-- QUERY 10: Busiest hours of the day
-- When do customers shop the most?
SELECT Hour, COUNT(*) AS orders
FROM sales
GROUP BY Hour
ORDER BY orders DESC
LIMIT 5;

