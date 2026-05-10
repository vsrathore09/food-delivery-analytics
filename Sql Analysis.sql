CREATE DATABASE food_delivery_analysis;
USE food_delivery_analysis;
SHOW TABLES;
SELECT * FROM orders LIMIT 5;

## TOTAL BUSINESS OVERVIEW :-

-- total revenue:-
SELECT
ROUND(SUM(final_amount),2)AS total_revenue
FROM orders;

/*
Result  : ₹1,81,61,760
Insight : The platform generated ₹1.81 Crore in total revenue across 20,000 orders. 
*/

-- total profit:- 
SELECT
ROUND(SUM(profit),2) AS total_profit
FROM orders;

/*
Result  : ₹1,38,04,584.20
Insight : Platform retained ₹1.38 Crore as profit, achieving an impressive ~76% profit margin. 
*/

-- total orders:-
SELECT
COUNT(order_id) AS total_orders
FROM orders;

/*
Result  : 20,000 orders
Insight : A high order count of 20,000 demonstrates consistent platform usage 
and strong customer engagement across all cities.
*/

-- average order value:- 
SELECT
ROUND(AVG(final_amount),2) AS avg_order_value
FROM orders;

/*
Result  : ₹908.09 per order
Insight : The average order value of ₹908 suggests customers are placing
medium-to-large sized orders, indicating preference for group meals or premium cuisines.
*/

-- total discount loss:-
SELECT
ROUND(SUM(discount_amount),2) AS total_discount_loss
FROM orders;

/*
Result  : ₹31,98,576
Insight : ₹31.98 Lakh was given as discounts — nearly 17.6% of total revenue.
While discounts drive volume, this level of discount spend needs monitoring to protect long-term profitability.
*/

## CUSTOMER ANALYSIS :-

-- customer segment revenue:-
SELECT c.customer_segment,
COUNT(DISTINCT o.customer_id) AS customers,
ROUND(SUM(o.final_amount),2) AS revenue
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_segment
ORDER BY revenue DESC;

/* 
Insight : Regular customers are the highest revenue-generating segment with ₹81.5 Lakh
from 2,208 users — making them the backbone of the platform.
Even the Inactive segment contributes ₹17.8 Lakh, showing re-engagement campaigns could unlock hidden revenue. 
*/

-- active vs inactive users:- 
SELECT is_active,
COUNT(*) AS total_customers FROM customers
GROUP BY is_active;

/*
Results :
Active   : 4,521 customers
Inactive :   479 customers
Insight : 90.4% of users are active on the platform — a strong retention rate.
The 479 inactive users represent an opportunity for win-back campaigns via targeted offers or push notifications.
*/ 

## CITY ANALYSIS :- 

-- top cities by revenue:-
SELECT city, ROUND(SUM(final_amount),2) AS revenue
FROM orders
GROUP BY city
ORDER BY revenue DESC;

/* 
Insight : Bangalore leads all cities with ₹20.8 Lakh in revenue — 11% higher than
the 2nd ranked city (Chennai). Metro cities dominate the top spots,
confirming stronger food delivery demand in urban regions.
*/

-- city profitability:-
SELECT city, ROUND(SUM(profit),2) AS total_profit
FROM orders
GROUP BY city
ORDER BY total_profit DESC;

/* 
Insight : Bangalore not only leads in revenue but also in profit at ₹15.7 Lakh,
suggesting lower discount dependency and better order economics in that city.
All top 5 cities maintain a consistent ~75% profit margin.
*/

-- high discount cities:- 
SELECT city, ROUND(SUM(discount_amount),2) AS total_discount
FROM orders
GROUP BY city
ORDER BY total_discount DESC;

/*
Insight : Bangalore receives the highest discount spend (₹3.7 Lakh), yet still leads
in revenue and profit — indicating high organic demand.
Jaipur has a notable discount-to-revenue ratio, suggesting heavier
discount reliance to drive orders compared to other cities.
*/

## RESTAURANT ANALYSIS :-

-- top restaurants :-
SELECT r.restaurant_name, ROUND(SUM(o.final_amount),2) AS revenue
FROM orders o
JOIN restaurants r
ON o.restaurant_id = r.restaurant_id
GROUP BY r.restaurant_name
ORDER BY revenue DESC
LIMIT 10;

/*
Insight : Arya LLC Kitchen leads with ₹75,242 in revenue — 4.5% ahead of #2.
The top 3 restaurants together account for a disproportionate share
of platform revenue, making them key partnership accounts.
*/

-- best rated restaurants:-
SELECT restaurant_name, rating
FROM restaurants
ORDER BY rating DESC
LIMIT 10;

/*
Insight : Multiple restaurants achieve a perfect 5.0 rating, reflecting strong
quality consistency. These restaurants are ideal candidates for
"Top Rated" badges or premium placement on the platform to drive more orders.
*/

-- cuisine performance:-
SELECT cuisine, ROUND(SUM(final_amount),2) AS revenue, ROUND(SUM(profit),2) AS profit
FROM orders
GROUP BY cuisine
ORDER BY revenue DESC;

/*
Insight : Pizza dominates with ₹21.25 Lakh revenue and ₹16.16 Lakh profit — the highest
across all cuisines. South Indian, Chinese, and Italian are nearly tied for 2nd
(within ₹6,000 of each other), showing diverse and balanced demand.
Healthy Food ranks last — a potential growth area for premium positioning.
*/

## DELIVERY ANALYSIS:- 

-- late delivery % :-
SELECT ROUND(SUM(CASE WHEN delivery_time_minutes > 60 THEN 1
ELSE 0 END) * 100.0 / COUNT(*),2) AS late_delivery_percentage
FROM delivery;

/*
Result  : 12.69% of orders were delivered late (>60 minutes)
Insight : Roughly 1 in 8 orders faces a delivery delay. While not alarming,
2,536 out of 20,000 orders being late can meaningfully impact.
*/

-- whether impact :-
SELECT weather_condition, ROUND(AVG(delivery_time_minutes),2) AS avg_delivery_time
FROM delivery
GROUP BY weather_condition
ORDER BY avg_delivery_time DESC;

/*
Insight : Rainy and stormy conditions increase average delivery time by ~31-32%
compared to clear weather (53 min vs 40 min). This is a significant
operational gap .
*/
 
-- traffic impact :-
SELECT 
traffic_level, ROUND(AVG(delivery_time_minutes),2) AS avg_delivery_time
FROM delivery
GROUP BY traffic_level;

/*  
Insight : High traffic conditions result in 55.7 min average delivery time —
46% slower than low/medium traffic (~38 min).
This confirms urban congestion is the single biggest driver of delivery delays,
more impactful than even weather conditions.
*/

## CANCELLATION ANALYSIS:-

-- payment method vs cancellation:- 
SELECT payment_method, COUNT(*) AS total_orders, 
SUM(is_cancelled) AS cancelled_orders, ROUND(SUM(is_cancelled) * 100.0/ COUNT(*),2) AS cancellation_rate
FROM orders
GROUP BY payment_method
ORDER BY cancellation_rate DESC;

/* 	
Insight : Cash on Delivery has a 17.88% cancellation rate — more than DOUBLE
the rate of all digital payment methods (~7.5-8%).
This strongly suggests COD customers cancel due to impulse orders or
payment friction at the door. Incentivizing digital payments
(UPI/Wallet cashback) could significantly reduce cancellations
and improve operational efficiency.
*/