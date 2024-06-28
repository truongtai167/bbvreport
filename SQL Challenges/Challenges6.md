## 1/ How many users are there?
```sql
SELECT count(distinct user_id) 
FROM clique_bait.users;
```
## 2/ How many cookies does each user have on average?
```sql
WITH cookie AS (SELECT 
	u.user_id,
    count(u.cookie_id) as cookie_id_count
FROM clique_bait.users u
GROUP BY user_id
)

SELECT 
  ROUND(AVG(cookie_id_count),0) AS avg_cookie_id
FROM cookie;
```
## 3/ What is the unique number of visits by all users per month?
```sql
SELECT
	EXTRACT(MONTH FROM event_time) as month_date,
	count(distinct visit_id)
FROM clique_bait.events
GROUP BY month_date
```
## 4/ What is the number of events for each event type?
```sql
SELECT
	event_type,
	count(*) as event_count
FROM clique_bait.events
GROUP BY event_type
```
## 5./ What is the percentage of visits which have a purchase event?
```sql
SELECT 
	ROUND (100 * count(distinct e.visit_id) / ( select count(distinct visit_id) from events),1)
FROM clique_bait.event_identifier i
JOIN events e on i.event_type = e.event_type
WHERE i.event_name = 'Purchase'
```
## 6/ What is the percentage of visits which view the checkout page but do not have a purchase event?
```sql
SELECT 
    COUNT(DISTINCT CASE WHEN page_id = '12' AND event_type = '1' THEN visit_id END) AS checkout,
    COUNT(DISTINCT CASE WHEN event_type = '3' THEN visit_id END) AS purchase,
	100 - (100* COUNT(DISTINCT CASE WHEN event_type = '3' THEN visit_id END) /  COUNT(DISTINCT CASE WHEN page_id = '12' AND event_type = '1' THEN visit_id END)) as checkout_not_purchase

FROM 
    clique_bait.events;
```
checkout bao gồm cả purchase và ko purchase

### 7/ What are the top 3 pages by number of views?
```sql
SELECT 
	e.page_id , 
	h.page_name ,
	count(e.visit_id) as visit_count
FROM clique_bait.events e
JOIN page_hierarchy h on e.page_id = h.page_id
WHERE e.event_type = '1'
GROUP BY e.page_id , h.page_name
ORDER BY visit_count DESC
LIMIT 3
```
### 8/  What is the number of views and cart adds for each product category?
```sql
SELECT 
  h.product_category,
  SUM(CASE WHEN e.event_type = 1 THEN 1 ELSE 0 END) AS page_views,
  SUM(CASE WHEN e.event_type = 2 THEN 1 ELSE 0 END) AS cart_adds
FROM events e 
JOIN page_hierarchy h on e.page_id = h.page_id
GROUP BY h.product_category
```
## 9/ What are the top 3 products by purchases?
```sql
WITH product_page_events AS ( -- Note 1
  SELECT 
    e.visit_id,
    ph.product_id,
    ph.page_name AS product_name,
    ph.product_category,
    SUM(CASE WHEN e.event_type = 1 THEN 1 ELSE 0 END) AS page_view, -- 1 for Page View
    SUM(CASE WHEN e.event_type = 2 THEN 1 ELSE 0 END) AS cart_add -- 2 for Add Cart
  FROM clique_bait.events AS e
  JOIN clique_bait.page_hierarchy AS ph
    ON e.page_id = ph.page_id
  WHERE product_id IS NOT NULL
  GROUP BY e.visit_id, ph.product_id, ph.page_name, ph.product_category
),
purchase_events AS ( -- Note 2
  SELECT 
    DISTINCT visit_id
  FROM clique_bait.events
  WHERE event_type = 3 -- 3 for Purchase
),
combined_table AS ( -- Note 3
  SELECT 
    ppe.visit_id, 
    ppe.product_id, 
    ppe.product_name, 
    ppe.product_category, 
    ppe.page_view, 
    ppe.cart_add,
    CASE WHEN pe.visit_id IS NOT NULL THEN 1 ELSE 0 END AS purchase
  FROM product_page_events AS ppe
  LEFT JOIN purchase_events AS pe
    ON ppe.visit_id = pe.visit_id
)
  SELECT 
    product_category, 
    SUM(CASE WHEN cart_add = 1 AND purchase = 1 THEN 1 ELSE 0 END) AS purchases
  FROM combined_table
  GROUP BY product_category
  ORDER BY purchases DESC
  ```

## B
## How many times was each product viewed? How many times was each product added to cart? How many times was each product added to a cart but not purchased (abandoned)? How many times was each product purchased?
```sql
WITH product_page_events AS ( -- Note 1
  SELECT 
    e.visit_id,
    ph.product_id,
    ph.page_name AS product_name,
    ph.product_category,
    SUM(CASE WHEN e.event_type = 1 THEN 1 ELSE 0 END) AS page_view, -- 1 for Page View
    SUM(CASE WHEN e.event_type = 2 THEN 1 ELSE 0 END) AS cart_add -- 2 for Add Cart
  FROM clique_bait.events AS e
  JOIN clique_bait.page_hierarchy AS ph
    ON e.page_id = ph.page_id
  WHERE product_id IS NOT NULL
  GROUP BY e.visit_id, ph.product_id, ph.page_name, ph.product_category
),
purchase_events AS ( -- Note 2
  SELECT 
    DISTINCT visit_id
  FROM clique_bait.events
  WHERE event_type = 3 -- 3 for Purchase
),
combined_table AS ( -- Note 3
  SELECT 
    ppe.visit_id, 
    ppe.product_id, 
    ppe.product_name, 
    ppe.product_category, 
    ppe.page_view, 
    ppe.cart_add,
    CASE WHEN pe.visit_id IS NOT NULL THEN 1 ELSE 0 END AS purchase
  FROM product_page_events AS ppe
  LEFT JOIN purchase_events AS pe
    ON ppe.visit_id = pe.visit_id
)
  SELECT 
    product_category, 
    SUM(page_view) AS views,
    SUM(cart_add) AS cart_adds, 
    SUM(CASE WHEN cart_add = 1 AND purchase = 0 THEN 1 ELSE 0 END) AS abandoned,
    SUM(CASE WHEN cart_add = 1 AND purchase = 1 THEN 1 ELSE 0 END) AS purchases
  FROM combined_table
  GROUP BY product_category
  ```
  
  
  
  
  
  
  
  
  
  
  
  
  



