
## select thong tin co ban cua mentee và số lượng người mentee đang theo dõi
```sql
SELECT 
    u.id,
    u.name,
    j.name as jobtitle,
    l.name as location,
    r.name as role,
    (SELECT COUNT(*) 
     FROM Follow 
     WHERE follower_id = 'U3') as total_followers
FROM Userr u 
JOIN Jobtitle j on u.jobtitle_id = j.id
JOIN Location l on u.location_id = l.id
JOIN Role r on u.role_id = r.id
WHERE u.id = 'U3';
```