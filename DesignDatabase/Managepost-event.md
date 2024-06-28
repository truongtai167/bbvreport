## dem so luong tat ca cac post
```sql
SELECT count(*) FROM post
```
## dem so luong tat ca cac post
```sql
SELECT count(*) FROM event
```

## lay tat ca cac post
```sql
SELECT * FROM post
```

## lay tat ca cac event
```sql
SELECT * FROM event
```
## lay total view cua event va post
```sql
WITH combined_views AS (
    SELECT views FROM Post
    UNION ALL
    SELECT views FROM Event
)
SELECT SUM(views) AS total_views
FROM combined_views;

```

