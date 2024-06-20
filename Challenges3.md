## 1. How many customers has Foodie-Fi ever had?
```sql
SELECT 
	count(distinct(customer_id))
FROM foodie_fi.subscriptions;
```

## 2. What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value
```sql
SELECT 
  EXTRACT(MONTH FROM s.start_date) AS month_of_day,
  COUNT(s.plan_id) AS trialcount
FROM foodie_fi.subscriptions s
JOIN foodie_fi.plans p on s.plan_id = p.plan_id
WHERE s.plan_id = '0'
GROUP BY month_of_day
ORDER BY month_of_day
```
## 3. What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name
```sql
SELECT
 s.plan_id,
 p.plan_name,
 count(s.plan_id)
FROM foodie_fi.subscriptions s
JOIN foodie_fi.plans p on s.plan_id = p.plan_id
WHERE s.start_date >= '2021-01-01'
GROUP BY s.plan_id , p.plan_name
ORDER BY s.plan_id
```
## 4. What is the customer count and percentage of customers who have churned rounded to 1 decimal place?
```sql
WITH total_customers AS (
  SELECT COUNT(DISTINCT customer_id) AS total
  FROM foodie_fi.subscriptions
)

, churned_customers AS (
  SELECT COUNT(DISTINCT customer_id) AS churned
  FROM foodie_fi.subscriptions
  WHERE plan_id = '4'
)

SELECT 
  churned_customers.churned,
  ROUND(100.0 * churned_customers.churned / total_customers.total, 1) AS churn_percentage
FROM 
  churned_customers, 
  total_customers;
```
## 5. How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?
```sql
SELECT 
    sub.customer_id,  
    plans.plan_name, 
	  LEAD(plans.plan_name) OVER ( 
      PARTITION BY sub.customer_id
      ORDER BY sub.start_date) AS next_plan
  FROM foodie_fi.subscriptions AS sub
  JOIN foodie_fi.plans 
    ON sub.plan_id = plans.plan_id

NOTE : LEAD là sẽ lấy những cột tiếp theo của plan_name theo start_date tiếp theo
```
## 6. What is the number and percentage of customer plans after their initial free trial?
```sql

WITH next_plans AS (
  SELECT 
    customer_id, 
    plan_id, 
    LEAD(plan_id) OVER(
      PARTITION BY customer_id 
      ORDER BY plan_id) as next_plan_id
  FROM foodie_fi.subscriptions
)


SELECT next_plan_id as plan_id,
count (customer_id),
ROUND(100.0 * count(customer_id)  / (select count(distinct customer_id )FROM foodie_fi.subscriptions),1) AS churn_percentage
FROM next_plans
WHERE next_plan_id IS NOT NULL and plan_id = '0'
GROUP BY next_plan_id
```

## 7. What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?
## 8. How many customers have upgraded to an annual plan in 2020?
## 9. How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?
## 10. Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)


## 11. How many customers downgraded from a pro monthly to a basic monthly plan in 2020?
```sql
WITH ranked_cte as (SELECT 
	s.customer_id,
    s.plan_id,
    plans.plan_name,
    LEAD(plans.plan_id) OVER(PARTITION BY s.customer_id ORDER BY s.start_date) as next_plan_id
 FROM foodie_fi.subscriptions AS s
 JOIN foodie_fi.plans 
     ON s.plan_id = plans.plan_id
 WHERE EXTRACT(YEAR FROM s.start_date) = 2020)

SELECT 
  COUNT(customer_id) AS churned_customers
FROM ranked_cte
WHERE plan_id = 2
  AND next_plan_id = 1;

```