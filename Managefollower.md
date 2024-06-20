## SELECT ALL FOLLOWER
```sql
SELECT * 
FROM Follow f 
JOIN Userr u on f.follower_id = u.id 
WHERE followee_id = 'U1'
```


## Dem so luong tat ca follower
```sql
SELECT count(*) 
FROM Follow f 
WHERE followee_id = 'U1'
```