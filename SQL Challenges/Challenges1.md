****CHALLENGES 1*****

## 1. What is the total amount each customer spent at the restaurant? What is the total amount each customer spent at the restaurant?
```sql 
Select s.customer_id , sum(price) as total
From dannys_diner.sales s
JOIN dannys_diner.menu m on s.product_id = m.product_id
GROUP BY s.customer_id
```


## 2. How many days has each customer visited the restaurant?
```sql
Select s.customer_id , count(distinct(s.order_date))
From dannys_diner.sales s
JOIN dannys_diner.menu m on s.product_id = m.product_id
GROUP BY s.customer_id
​```


## 3. What was the first item from the menu purchased by each customer?
```sql
WITH FirstPurchaseDates AS (
    SELECT 
        customer_id, 
        MIN(order_date) AS first_order_date
    FROM dannys_diner.sales
    GROUP BY customer_id
)


SELECT 
    s.customer_id,
    m.product_name
FROM 
    FirstPurchaseDates fp
JOIN 
    dannys_diner.sales s ON fp.customer_id = s.customer_id AND fp.first_order_date = s.order_date
JOIN 
    dannys_diner.menu m ON s.product_id = m.product_id
GROUP BY 
    s.customer_id,m.product_name
ORDER BY 
    s.customer_id,m.product_name
```

## 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
```sql
WITH TIMEPURCHASE AS (
  SELECT COUNT(m.product_name) as timepurchase, m.product_name
FROM dannys_diner.menu m
JOIN dannys_diner.sales s on m.product_id = s.product_id
GROUP BY m.product_name)


SELECT tp.product_name, tp.timepurchase
FROM TIMEPURCHASE tp
WHERE tp.timepurchase = (
    SELECT MAX(timepurchase)
    FROM TIMEPURCHASE
);
```

## 5. Which item was the most popular for each customer?
```sql
SELECT 
    sales.customer_id,
    menu.product_name,
    COUNT(menu.product_id) AS order_count
FROM dannys_diner.menu
INNER JOIN dannys_diner.sales
    ON menu.product_id = sales.product_id
GROUP BY sales.customer_id, menu.product_name
HAVING COUNT(menu.product_id) = (
    SELECT MAX(product_count)
    FROM (
        SELECT 
            sales_inner.customer_id, 
            COUNT(sales_inner.product_id) AS product_count
        FROM dannys_diner.sales as sales_inner
        WHERE sales_inner.customer_id = sales.customer_id
        GROUP BY sales_inner.customer_id, sales_inner.product_id
    ) AS subquery
);
```

## 6. Which item was purchased first by the customer after they became a member?
```sql
WITH MINORDERDATE AS (SELECT 
        s.customer_id,
        MIN(s.order_date) AS first_order_date
    FROM dannys_diner.sales s
    JOIN dannys_diner.members m ON s.customer_id = m.customer_id
    JOIN dannys_diner.menu me ON s.product_id = me.product_id
    WHERE m.join_date < s.order_date
    GROUP BY s.customer_id)
SELECT s.customer_id , m.product_name
FROM dannys_diner.sales s
JOIN MINORDERDATE mo on s.customer_id = mo.customer_id and s.order_date = mo.first_order_date
JOIN dannys_diner.menu m on s.product_id = m.product_id
```
## 7. Which item was purchased just before the customer became a member?
```sql
WITH MINORDERDATE AS (SELECT 
        s.customer_id,
        MAX(s.order_date) AS first_order_date
    FROM dannys_diner.sales s
    JOIN dannys_diner.members m ON s.customer_id = m.customer_id
    JOIN dannys_diner.menu me ON s.product_id = me.product_id
    WHERE m.join_date > s.order_date
    GROUP BY s.customer_id)
SELECT s.customer_id , m.product_name
FROM dannys_diner.sales s
JOIN MINORDERDATE mo on s.customer_id = mo.customer_id and s.order_date = mo.first_order_date
JOIN dannys_diner.menu m on s.product_id = m.product_id
```
## 8. What is the total items and amount spent for each member before they became a member?
```sql
WITH customer_summary AS (
    SELECT 
        s.customer_id, 
        me.product_name,
        COUNT(me.product_name) AS total,
        SUM(me.price) AS totalprice
    FROM dannys_diner.sales s
    JOIN dannys_diner.members m ON s.customer_id = m.customer_id
    JOIN dannys_diner.menu me ON s.product_id = me.product_id
    WHERE m.join_date > s.order_date
    GROUP BY s.customer_id, me.product_name
    ORDER BY s.customer_id
)
SELECT
    customer_id,
    SUM(total) AS total_products,
    SUM(totalprice) AS total_money
FROM customer_summary
GROUP BY customer_id
ORDER BY customer_id;
```
## 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
```sql
SELECT
    s.customer_id,
    SUM(CASE
            WHEN me.product_name = 'sushi' THEN me.price * 20
            ELSE me.price * 10
        END) AS totalpoints
FROM dannys_diner.sales s
JOIN dannys_diner.menu me ON s.product_id = me.product_id
GROUP BY s.customer_id
ORDER BY s.customer_id;
```
## 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
```sql
SELECT
    s.customer_id,
    SUM(CASE
            WHEN s.order_date <= (mb.join_date + 6) THEN me.price * 20
            ELSE me.price * 10
        END) AS totalpoints
FROM dannys_diner.sales s
JOIN dannys_diner.menu me ON s.product_id = me.product_id
JOIN dannys_diner.members mb ON s.customer_id = mb.customer_id
WHERE s.order_date < '2021-01-31' and s.order_date >= mb.join_date
GROUP BY s.customer_id
ORDER BY s.customer_id;
```
