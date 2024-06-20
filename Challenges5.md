## 1/ What day of the week is used for each week_date value?
```sql
SELECT DISTINCT(DATE_FORMAT(week_date, '%W')) AS week_day 
FROM clean_weekly_sales;
```
## 2/ What range of week numbers are missing from the dataset?
```sql
WITH RECURSIVE week_number_cte AS (
    SELECT 1 AS week_number
    UNION ALL
    SELECT week_number + 1
    FROM week_number_cte
    WHERE week_number < 52
)
SELECT
	week_no.week_number
FROM week_number_cte AS week_no
LEFT JOIN clean_weekly_sales AS sales
  ON week_no.week_number = sales.week_number
WHERE sales.week_number is NULL
ORDER BY week_no.week_number
```
## 3/ How many total transactions were there for each year in the dataset?
```sql
SELECT 
  calendar_year, 
  SUM(transactions) AS total_transactions
FROM clean_weekly_sales
GROUP BY calendar_year
ORDER BY calendar_year;
``` 
## 4/ What is the total sales for each region for each month?
```sql
SELECT 
	region, 
    sum(sales),
    month_number
FROM data_mart.clean_weekly_sales
GROUP BY region , month_number
order by month_number
```
## 5/ What is the total count of transactions for each platform?
```sql
SELECT 
 platform,
 sum(transactions)
FROM data_mart.clean_weekly_sales
GROUP BY platform
```
## 6/ What is the percentage of sales for Retail vs Shopify for each month?

Cach 1
```sql
SELECT 
    calendar_year, 
    month_number, 
    platform, 
    SUM(sales) AS monthly_sales,
    ROUND(SUM(sales)/
		SUM(SUM(sales)) OVER (PARTITION BY calendar_year,month_number) *100,2) as percentage
FROM clean_weekly_sales
GROUP BY calendar_year, month_number, platform
```

Canh 2
```sql
with cte as (
SELECT 
	month_number, 
	platform,calendar_year, 
	sum(sales) as monthly_sale 
	FROM clean_weekly_sales 
	group by  month_number, platform,calendar_year),
    
		
cte_2 as (Select 
	ROUND (100*monthly_sale/(lead(monthly_sale) over (partition by month_number,calendar_year order by platform)+monthly_sale),2) as percentage,
    month_number, 
    platform,
    calendar_year
from cte 
group by month_number, platform,calendar_year, monthly_sale)

SELECT 
    COALESCE(
        percentage, 
        100 - LAG(percentage) OVER (PARTITION BY month_number, calendar_year ORDER BY platform)
    ) AS percentage, 
    month_number, 
    platform, 
    calendar_year
FROM cte_2
ORDER BY calendar_year, month_number, platform;
```
## 7/ What is the percentage of sales by demographic for each year in the dataset?
```sql
SELECT 
calendar_year,
demographic , 
sum(sales),
ROUND(SUM(sales)/
		SUM(SUM(sales)) OVER (PARTITION BY calendar_year) *100,2) as percentage
FROM clean_weekly_sales
GROUP BY demographic , calendar_year
```
## 8/ Which age_band and demographic values contribute the most to Retail sales?
```sql
SELECT 
	age_band,
	demographic,
    ROUND (100 * sum(sales)/sum(sum(sales)) OVER () ,2) as sales_percentage
FROM data_mart.clean_weekly_sales
WHERE platform = 'Retail'
GROUP BY age_band , demographic
ORDER BY sales DESC
```
## 9/ Can we use the avg_transaction column to find the average transaction size for each year for Retail vs Shopify? If not - how would you calculate it instead?
```sql
SELECT 
	platform,
    calendar_year,
	ROUND (AVG(avg_transaction),1)
FROM data_mart.clean_weekly_sales
GROUP BY platform , calendar_year
```
## C/ 
## 1/ What is the total sales for the 4 weeks before and after 2020-06-15? What is the growth or reduction rate in actual values and percentage of sales?
```sql
SELECT DISTINCT 
    DATE_SUB('2020-06-15', INTERVAL 4 WEEK) AS Date_Before, 
    DATE_ADD('2020-06-15', INTERVAL 4 WEEK) AS Date_After
FROM clean_weekly_sales;
Note Lệnh này dùng để tìm ra ngày sau 4 tuần và ngày trước 4 tuần
with cte as (SELECT 
    week_date,
    sales,
   SUM(CASE 
            WHEN week_date >= '2020-05-18' AND week_date < '2020-06-15' THEN sales 
            ELSE 0 
        END) AS before_date,
   SUM(CASE 
            WHEN week_date >= '2020-06-15' AND week_date < '2020-07-13' THEN sales 
            ELSE 0 
        END) AS after_date
FROM 
    clean_weekly_sales
WHERE 
    calendar_year = '2020'
GROUP BY 
    week_date)
    
SELECT
    SUM(before_date) as total_before ,
    SUM(after_date) as total_after,
    SUM(after_date) - SUM(before_date) as salediff,
    ROUND(100 * (SUM(after_date) - SUM(before_date))/SUM(before_date),2)
FROM cte;
```
## 2/ What about the entire 12 weeks before and after? 
tương tự câu trên (11 weeks)

## 3/  How do the sale metrics for these 2 periods before and after compare with the previous years in 2018 and 2019?
```sql
with cte as (SELECT 
    calendar_year,
   SUM(CASE 
            WHEN (week_date >= '2020-05-18' AND week_date < '2020-06-15' ) OR
				 (week_date >= '2019-05-18' AND week_date < '2019-06-15') OR
				 (week_date >= '2018-05-18' AND week_date < '2018-06-15')
            THEN sales 
            ELSE 0 
        END) AS before_date,
   SUM(CASE 
            WHEN (week_date >= '2020-06-15' AND week_date < '2020-07-13') OR
				 (week_date >= '2019-06-15' AND week_date < '2019-07-13') OR
				 (week_date >= '2018-06-15' AND week_date < '2018-07-13')
            THEN sales 
            ELSE 0 
        END) AS after_date
FROM 
    clean_weekly_sales
GROUP BY 
    calendar_year)
    
SELECT
	calendar_year,
    SUM(before_date) as total_before ,
    SUM(after_date) as total_after,
    SUM(after_date) - SUM(before_date) as salediff,
    ROUND(100 * (SUM(after_date) - SUM(before_date))/SUM(before_date),2)
FROM cte
GROUP BY calendar_year
```

