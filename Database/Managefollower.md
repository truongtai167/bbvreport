## SELECT ALL FOLLOWER
```sql
SELECT u.name,l.name,DATE(f.datefollow)
FROM followuser f
JOIN userr u on f.follower_id = u.id
JOIN location l on u.location_id = l.id
WHERE f.followee_id = 'U1'

```
## Dem so luong tat ca follower
```sql
SELECT count(*) 
FROM Follow f 
WHERE followee_id = 'U1'
```

## dem new follower
SELECT COUNT(*) AS newuser
FROM followuser f
WHERE DATE(f.datefollow) = CURDATE();