## 1. How many pizzas were ordered?
```sql
SELECT COUNT(*) AS pizza_order_count
FROM customer_orders_temp;
```

## 2. How many unique customer orders were made?
```sql
SELECT COUNT(DISTINCT order_id) AS unique_order_count
FROM customer_orders_temp;
```

## 3. How many successful orders were delivered by each runner?
```sql
SELECT 
  runner_id, 
  COUNT(order_id) AS successful_orders
FROM pizza_runner.runner_orders_temp
WHERE distance != 0
GROUP BY runner_id
ORDER BY runner_id;
```

## 4. How many of each type of pizza was delivered?
```sql
SELECT 
  p.pizza_name,
  count(p.pizza_name)
FROM pizza_runner.customer_orders_temp AS c
JOIN pizza_runner.runner_orders_temp AS r
  ON c.order_id = r.order_id
JOIN pizza_runner.pizza_names AS p
  ON c.pizza_id = p.pizza_id
WHERE r.distance != 0
GROUP BY p.pizza_name
```
## 5. How many Vegetarian and Meatlovers were ordered by each customer?
```sql
SELECT 
  c.customer_id,
  p.pizza_name,
  count(p.pizza_name)
FROM pizza_runner.customer_orders AS c
JOIN pizza_runner.pizza_names AS p
  ON c.pizza_id = p.pizza_id
GROUP BY c.customer_id,p.pizza_name
ORDER BY c.customer_id
```


## 6. What was the maximum number of pizzas delivered in a single order?
```sql
SELECT 
	c.order_id,
    count(c.order_id)
FROM pizza_runner.customer_orders_temp AS c
JOIN pizza_runner.runner_orders_temp AS r
  ON c.order_id = r.order_id
WHERE r.distance != 0
GROUP BY c.order_id
ORDER BY c.order_id
```
## 7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?


## 8. How many pizzas were delivered that had both exclusions and extras?
```sql 
SELECT 
	count(c.order_id)
FROM pizza_runner.customer_orders AS c
JOIN pizza_runner.runner_orders AS r
  ON c.order_id = r.order_id
WHERE r.distance != 'null' and c.exclusions != 'null' and c.exclusions IS NOT NULL and c.extras != 'null'  and c.extras IS NOT NULL and c.exclusions <> '' and c.extras <> '' 
```
## 9. What was the total volume of pizzas ordered for each hour of the day?
```sql
SELECT 
  EXTRACT(HOUR FROM order_time) AS hour_of_day, 
  COUNT(order_id) AS pizza_count
FROM pizza_runner.customer_orders AS c
GROUP BY hour_of_day
ORDER BY hour_of_day;
```
## 10. What was the volume of orders for each day of the week?
```sql
+ POSTgre: 

SELECT 
  TO_CHAR(order_time + INTERVAL '2 day', 'Day') AS day_of_week,
  COUNT(order_id) AS total_pizzas_ordered
FROM pizza_runner.customer_orders
GROUP BY day_of_week
ORDER BY day_of_week;

+ MYSQL_server : 

SELECT 
  DATE_FORMAT(DATE_ADD(order_time, INTERVAL 2 DAY), '%W') AS day_of_week,
  COUNT(order_id) AS total_pizzas_ordered
FROM pizza_runner.customer_orders
GROUP BY day_of_week
ORDER BY day_of_week;

NOTE : +2 ngay' boi vi' 1/1/2020 la thu 6 , +2 ngay de no tinh tu thu 2
```

## B. Runner and Customer Experience

## 1. How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
```sql
SELECT EXTRACT(WEEK FROM registration_date + 3) AS week_of_year,
   COUNT(runner_id)
FROM runners
GROUP BY week_of_year
ORDER BY week_of_year;


SELECT EXTRACT(WEEK FROM registration_date) 
```
NOTE : thi' se~ ra ngay' 2021-01-01 la tuan thu 53 thu 6 , vi vay phai + them 3 ngay' de tro thanh tuan thu 1 cua nam 

## 2. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
```sql

+ POSTgre : 
with cte as (SELECT 
    c.order_id, 
    c.order_time::timestamp, -- Convert to timestamp if stored as character varying
    r.pickup_time::timestamp, -- Convert to timestamp if stored as character varying
    EXTRACT(EPOCH FROM (r.pickup_time::timestamp - c.order_time::timestamp)) / 60 AS pickup_minutes (EPOCH doi ra thanh second xong / 60 de thanh minute)
FROM 
    pizza_runner.customer_orders AS c
    JOIN pizza_runner.runner_orders AS r ON c.order_id = r.order_id
WHERE 
    r.distance != 'null'
GROUP BY 
    c.order_id, c.order_time, r.pickup_time)
    
SELECT AVG(pickup_minutes)
FROM cte



+ MySQL_server

with cte as (SELECT 
    c.order_id, 
    CAST(c.order_time AS DATETIME) AS order_time, 
    CAST(r.pickup_time AS DATETIME) AS pickup_time, 
    TIMESTAMPDIFF(MINUTE, CAST(c.order_time AS DATETIME), CAST(r.pickup_time AS DATETIME)) AS pickup_minutes
FROM 
    pizza_runner.customer_orders AS c
    JOIN pizza_runner.runner_orders AS r ON c.order_id = r.order_id
WHERE 
    r.distance IS NOT NULL
GROUP BY 
    c.order_id, order_time, pickup_time)

SELECT AVG(pickup_minutes)
FROM cte

```
## 3. Is there any relationship between the number of pizzas and how long the order takes to prepare?
```sql

with cte as (SELECT 
    c.order_id, 
    COUNT(c.order_id) AS pizza_order,
    CAST(c.order_time AS DATETIME) AS order_time, 
    CAST(r.pickup_time AS DATETIME) AS pickup_time, 
    TIMESTAMPDIFF(MINUTE, CAST(c.order_time AS DATETIME), CAST(r.pickup_time AS DATETIME)) AS pickup_minutes
FROM 
    pizza_runner.customer_orders AS c
    JOIN pizza_runner.runner_orders AS r ON c.order_id = r.order_id
WHERE 
    r.distance != 0
GROUP BY 
    c.order_id, order_time, pickup_time)

SELECT
	pizza_order,
	ROUND(AVG(pickup_minutes),0)
FROM cte
GROUP BY pizza_order
```
## 4. What was the average distance travelled for each customer?
```sql
SELECT 
	customer_id,
	AVG(distance)
FROM pizza_runner.customer_orders_temp c
JOIN runner_orders_temp r on c.order_id = r.order_id
WHERE distance != 0
GROUP BY customer_id
```


## 5. What was the difference between the longest and shortest delivery times for all orders?
```sql
SELECT 
	MAX(duration),
    MIN(duration),
    MAX(duration) - MIN(duration) 
FROM runner_orders_temp
WHERE duration != 0
```

## 6. What was the average speed for each runner for each delivery and do you notice any trend for these values?

## 7. What is the successful delivery percentage for each runner?
```sql
SELECT 
  runner_id, 
  ROUND(100 * SUM(
    CASE WHEN distance = 0 THEN 0
    ELSE 1 END) / COUNT(*), 0) AS success_perc
FROM runner_orders
GROUP BY runner_id;
```
