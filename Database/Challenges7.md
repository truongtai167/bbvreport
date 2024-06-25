## 1/ What was the total quantity sold for all products?
```sql
SELECT 
	p.product_name,
	SUM(b.qty) as total
FROM balanced_tree.sales b
JOIN product_details p on b.prod_id = p.product_id
GROUP BY p.product_name
```
## 2/ What is the total generated revenue for all products before discounts?
```sql
SELECT 
	p.product_name,
    SUM(b.qty*b.price) as price_before_discount
FROM balanced_tree.sales b
JOIN product_details p on b.prod_id = p.product_id
GROUP BY p.product_name
```
## 3/ What was the total discount amount for all products?
```sql
SELECT 
	p.product_name,
    SUM(b.discount) as price_before_discount
FROM balanced_tree.sales b
JOIN product_details p on b.prod_id = p.product_id
GROUP BY p.product_name
```

### B/
## 1/ How many unique transactions were there?
```sql
SELECT count(distinct txn_id) 
FROM balanced_tree.sales;
```
## 2/ What is the average unique products purchased in each transaction?
```sql
with prods as (
select 
	distinct txn_id,
    count(prod_id)over(partition by txn_id) as prod
from sales)

select 
ROUND(AVG(prod),0)
from prods
```
## 3/  What are the 25th, 50th and 75th percentile values for the revenue per transaction?
```sql
with revenue_cte as (SELECT 
	txn_id,
    sum(qty * price) as revenue
FROM balanced_tree.sales
GROUP BY txn_id
ORDER BY revenue ),
ranked_revenue AS (
    SELECT
        revenue,
        PERCENT_RANK() OVER (ORDER BY revenue) AS percentile_rank
    FROM
        revenue_cte
)
SELECT
    MIN(CASE WHEN percentile_rank >= 0.25 THEN revenue END) AS median_25th,
    MIN(CASE WHEN percentile_rank >= 0.50 THEN revenue END) AS median_50th,
    MIN(CASE WHEN percentile_rank >= 0.75 THEN revenue END) AS median_75th
FROM
    ranked_revenue;
```
## 4/ What is the average discount value per transaction?
```sql
with cte as (SELECT 
	distinct txn_id,
    SUM(discount) as total_discount
FROM balanced_tree.sales
GROUP BY txn_id)

select 
 AVG(total_discount)
FROM cte
```
## 5/ What is the percentage split of all transactions for members vs non-members?
```sql
WITH transactions_cte AS (
  SELECT
    member,
    COUNT(DISTINCT txn_id) AS transactions
  FROM balanced_tree.sales
  GROUP BY member
)
SELECT 
	member,
	ROUND (100 * transactions/ (SELECT sum(transactions) from transactions_cte), 0) as percentage_transaction
FROM
 transactions_cte
GROUP BY member
```
## 6/ What is the average revenue for member transactions and non-member transactions?
```sql
WITH transactions_cte AS (
  SELECT
    member,
    txn_id,
    SUM(qty*price) as total_revenue
  FROM balanced_tree.sales
  GROUP BY member,txn_id
)
SELECT 
	member,
	AVG(total_revenue)
FROM
 transactions_cte
GROUP BY member
```
## C/
## 1/ What are the top 3 products by total revenue before discount?
```sql
SELECT
	p.product_id,
	p.product_name,
    SUM(s.qty * s.price) as revenue_no_discount
FROM sales s
INNER JOIN product_details p on s.prod_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY revenue_no_discount DESC
LIMIT 3
```
## 2/ What is the total quantity, revenue and discount for each segment?
```sql
SELECT
	p.segment_name,
    SUM(s.qty) as quantity,
    SUM(s.price * s.qty) as revenue,
    SUM(s.discount) as discount
FROM sales s
INNER JOIN product_details p on s.prod_id = p.product_id
GROUP BY p.segment_name
```
## 3/ What is the top selling product for each segment?
```sql
WITH top_selling_cte AS ( 
  SELECT 
    product.segment_id,
    product.segment_name, 
    product.product_id,
    product.product_name,
    SUM(sales.qty) AS total_quantity,
    RANK() OVER (
      PARTITION BY segment_id 
      ORDER BY SUM(sales.qty) DESC) AS ranking
  FROM balanced_tree.sales
  INNER JOIN balanced_tree.product_details AS product
    ON sales.prod_id = product.product_id
  GROUP BY 
    product.segment_id, product.segment_name, product.product_id, product.product_name
)

SELECT 
  segment_id,
  segment_name, 
  product_id,
  product_name,
  total_quantity
FROM top_selling_cte
WHERE ranking = 1;
```
## 4/ What is the total quantity, revenue and discount for each category?
```sql
SELECT
	p.category_id,
    p.category_name,
    SUM(s.qty) as quantity,
    SUM(s.price * s.qty) as revenue,
    SUM(s.discount) as discount
FROM sales s
INNER JOIN product_details p on s.prod_id = p.product_id
GROUP BY p.category_id, p.category_name
```
## 5/ What is the top selling product for each category?
```sql
WITH top_selling_cte AS ( 
  SELECT 
    product.category_id,
    product.category_name,
    product.product_id,
    product.product_name,
    SUM(sales.qty) AS total_quantity,
    RANK() OVER (
      PARTITION BY category_id
      ORDER BY SUM(sales.qty) DESC) AS ranking
  FROM balanced_tree.sales
  INNER JOIN balanced_tree.product_details AS product
    ON sales.prod_id = product.product_id
  GROUP BY 
   product.category_id,
    product.category_name,
    product.product_id,
    product.product_name
)

SELECT 
  category_id,
  category_name,
  product_id,
  product_name,
  total_quantity
FROM top_selling_cte
WHERE ranking = 1;
```

