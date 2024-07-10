## dem so luong tat ca cac event cua user
```sql
SELECT count(*) from event
WHERE user_id = 1
```

## lay tat ca cac participants cua 1 user tu cac event
```sql
SELECT count(*) as participants from EventUser
Where user_id = 1
```

## lay tat ca cac event
```sql
SELECT 
    e.*,
    (SELECT COUNT(*) FROM EventUser WHERE event_id = e.id) AS participants
FROM EVENT e
WHERE e.user_id = 1;
```
## lay total view cua event 
```sql
WITH combined_views AS (
    SELECT views 
    FROM Event
    WHERE user_id = 1
)
SELECT SUM(views) AS total_views
FROM combined_views;
```

## Sort by last updated
```sql 
SELECT * FROM EVENT
WHERE user_id = 1
ORDER BY createAT
```