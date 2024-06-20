## 2/ What is count of records in the fresh_segments.interest_metrics for each month_year value sorted in chronological order (earliest to latest) with the null values appearing first?
```sql
SELECT 
	month_year,
    count(*) as records
FROM fresh_segments.interest_metrics
GROUP BY month_year
ORDER BY month_year IS NOT NULL 
```
## 3/ What do you think we should do with these null values in the fresh_segments.interest_metrics?
```sql
DELETE FROM fresh_segments.interest_metrics
WHERE interest_id IS NULL;
```
## 4/ How many interest_id values exist in the fresh_segments.interest_metrics table but not in the fresh_segments.interest_map table? What about the other way around?
```sql
SELECT 
  (SELECT COUNT(DISTINCT interest_id) 
   FROM interest_metrics 
   WHERE interest_id NOT IN (SELECT id FROM interest_map)) AS Ids_not_in_maps,
  
  (SELECT COUNT(id) 
   FROM interest_map 
   WHERE id NOT IN (SELECT interest_id FROM interest_metrics)) AS Ids_not_in_metrics;

```
## 5/ Summarise the id values in the fresh_segments.interest_map by its total record count in this table.
```sql
SELECT COUNT(*)
FROM fresh_segments.interest_map
```
## 7/ Are there any records in your joined table where the month_year value is before the created_at value from the fresh_segments.interest_map table? Do you think these values are valid and why?
```sql
SELECT 
  COUNT(*)
FROM fresh_segments.interest_map map
INNER JOIN fresh_segments.interest_metrics metrics
  ON map.id = metrics.interest_id
WHERE EXTRACT(MONTH from metrics.month_year) < extract(MONTH from map.created_at);
```

## B/
## 1/ Which interests have been present in all month_year dates in our dataset?
```sql
WITH interest_cte AS (
SELECT 
  interest_id, 
  COUNT(DISTINCT month_year) AS total_months
FROM fresh_segments.interest_metrics
WHERE month_year IS NOT NULL
GROUP BY interest_id
)

SELECT 
  c.total_months,
  COUNT(DISTINCT c.interest_id) as count
FROM interest_cte c
WHERE total_months = 14
GROUP BY c.total_months
ORDER BY count DESC;
```
## 2/ Using this same total_months measure - calculate the cumulative percentage of all records starting at 14 months - which total_months value passes the 90% cumulative percentage value?

## 3/ If we were to remove all interest_id values which are lower than the total_months value we found in the previous question - how many total data points would we be removing?

