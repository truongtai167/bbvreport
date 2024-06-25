## A. Customer Nodes Exploration
## 1/ How many unique nodes are there on the Data Bank system?
```sql
SELECT 
count(distinct node_id)
From data_bank.customer_nodes
```
## 2/ What is the number of nodes per region?
```sql
SELECT 
 c.region_id,
 count(distinct c.node_id)
From data_bank.customer_nodes c 
JOIN data_bank.regions g on c.region_id = g.region_id
GROUP BY c.region_id
```
## 3/ How many customers are allocated to each region?
```sql
SELECT 
 c.region_id,
 count(c.customer_id)
From data_bank.customer_nodes c 
JOIN data_bank.regions g on c.region_id = g.region_id
GROUP BY c.region_id
```

##  4/ How many days on average are customers reallocated to a different node?
```sql
WITH node_days AS (
  SELECT 
    customer_id, 
    node_id,
    end_date - start_date AS days_in_node
  FROM data_bank.customer_nodes
  WHERE end_date != '9999-12-31'
  GROUP BY customer_id, node_id, start_date, end_date
) 
, total_node_days AS (
  SELECT 
    customer_id,
    node_id,
    SUM(days_in_node) AS total_days_in_node
  FROM node_days
  GROUP BY customer_id, node_id
)
```
## 5/ What is the median, 80th and 95th percentile for this same reallocation days metric for each region?
```sql
WITH dayscte AS (
    SELECT 
        c.region_id,
        r.region_name,
        end_date - start_date AS reallocation_days
    FROM data_bank.customer_nodes AS c
    INNER JOIN data_bank.regions AS r on c.region_id = r.region_id
    WHERE end_date != '9999-12-31'
)
 SELECT 
        region_name,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY reallocation_days) AS median,
        PERCENTILE_CONT(0.80) WITHIN GROUP (ORDER BY reallocation_days) AS percentile_80,
        PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY reallocation_days)AS percentile_95
FROM dayscte
GROUP BY region_name
```
## B. Customer Transactions

##  1/ What is the unique count and total amount for each transaction type?
```sql
SELECT 
	c.txn_type,
    count(c.customer_id),
    sum(c.txn_amount)
From data_bank.customer_transactions  c
GROUP BY c.txn_type
```

## 2/  What is the average total historical deposit counts and amounts for all customers?
```sql
WITH deposits AS (
  SELECT 
    customer_id, 
    COUNT(customer_id) AS txn_count, 
    AVG(txn_amount) AS avg_amount
  FROM data_bank.customer_transactions
  WHERE txn_type = 'deposit'
  GROUP BY customer_id
)

SELECT 
  ROUND(AVG(txn_count)) AS avg_deposit_count, 
  ROUND(AVG(avg_amount)) AS avg_deposit_amt
FROM deposits;
```
## 3/ For each month - how many Data Bank customers make more than 1 deposit and either 1 purchase or 1 withdrawal in a single month?
```sql
  WITH abc as (SELECT 
    customer_id, 
    EXTRACT(MONTH FROM txn_date) AS month_of_day,
    SUM(CASE WHEN txn_type = 'deposit' THEN 1 ELSE 0 END) AS deposit_count,
    SUM(CASE WHEN txn_type = 'purchase' THEN 1 ELSE 0 END) AS purchase_count,
    SUM(CASE WHEN txn_type = 'withdrawal' THEN 1 ELSE 0 END) AS withdrawal_count
  FROM data_bank.customer_transactions
  GROUP BY customer_id,month_of_day)
  
  SELECT 
  	month_of_day ,
    count(distinct customer_id)
  FROM abc
  WHERE deposit_count > 1 and (purchase_count >= 1 OR withdrawal_count >= 1)
  GROUP BY month_of_day
```
## 4/ What is the closing balance for each customer at the end of the month?
```sql
WITH AmountCte AS (SELECT 
   	customer_id,
   	EXTRACT(MONTH FROM txn_date) AS month,
   	SUM(CASE 
   	WHEN txn_type = 'deposit' THEN txn_amount ELSE -txn_amount END) AS amount
   FROM data_bank.customer_transactions
   GROUP BY customer_id, month
   ORDER BY customer_id
 )
SELECT 
    a.customer_id, 
    a.month,
    SUM(b.amount) AS closing_balance
FROM AmountCte a
JOIN AmountCte b 
    ON a.customer_id = b.customer_id 
    AND a.month >= b.month
GROUP BY a.customer_id, a.month
ORDER BY a.customer_id, a.month;
```
  
  