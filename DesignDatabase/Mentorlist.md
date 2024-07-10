# lay tat ca location 
```sql
SELECT name from location
```
# lay tat ca jobtitle 
```sql
SELECT * FROM Jobtitle
```
## list mentor default khi chưa có filter sẽ sort theo tên 
```sql 

SELECT 
    u.id,
    u.name,
    l.name as location,
    j.name AS jobtitle,
    u.role_id,
    COALESCE(AVG(f.rating_star), 0) AS average_rating
FROM [User] u
JOIN Jobtitle j ON u.jobtitle_id = j.id
JOIN Location l on u.location_id = l.id
LEFT JOIN Program p ON u.id = p.user_id
LEFT JOIN Challenge c ON u.id = c.user_id
LEFT JOIN Course co ON u.id = co.user_id
LEFT JOIN Review f ON f.source_id = p.id OR f.source_id = c.id OR f.source_id = co.id
WHERE u.role_id = (SELECT setting_value FROM GetSettingValue('Role','Mentor') )
GROUP BY u.id, u.name, l.name, j.name, u.role_id
ORDER BY u.name ASC;
```
## lay mentor rating theo location va top rating
```sql
SELECT 
	u.id, u.name, l.name as location, u.role_id , j.name as jobtitle
	,COALESCE(AVG(f.rating_star),0) as average_rating
FROM [User] u
JOIN Jobtitle j ON  u.jobtitle_id = j.id
JOIN Location l on u.location_id = l.id
LEFT JOIN Program p ON u.id = p.user_id
LEFT JOIN Challenge c ON u.id = c.user_id
LEFT JOIN Course co ON u.id = co.user_id
LEFT JOIN Review f ON f.source_id = p.id OR f.source_id = c.id OR f.source_id = co.id
WHERE l.name ='Ho Chi Minh' AND u.role_id = (SELECT setting_value FROM GetSettingValue('Role','Mentor') )
GROUP BY u.id, u.name, l.name, j.name, u.role_id
ORDER BY average_rating DESC;

```
## Lay mentor theo top rating (program , challenges , course)
```sql
SELECT 
    u.id,
    u.name,
    l.name as location,
    j.name AS jobtitle,
    u.role_id,
    COALESCE(AVG(f.rating_star), 0) AS average_rating
FROM [User] u
JOIN Jobtitle j ON u.jobtitle_id = j.id
JOIN Location l on u.location_id = l.id
LEFT JOIN Program p ON u.id = p.user_id
LEFT JOIN Challenge c ON u.id = c.user_id
LEFT JOIN Course co ON u.id = co.user_id
LEFT JOIN Review f ON f.source_id = p.id OR f.source_id = c.id OR f.source_id = co.id
WHERE u.role_id = '5'
GROUP BY u.id, u.name, u.location_id,l.name, j.name, u.role_id
ORDER BY average_rating DESC;

```
## Lay mentor theo jobtitle va top rating
```sql
SELECT 
	u.id, u.name, l.name as location, j.name as jobtitle, u.role_id
	,COALESCE(AVG(f.rating_star),0) as average_rating
FROM [User] u
JOIN Jobtitle j ON  u.jobtitle_id = j.id
JOIN Location l on u.location_id = l.id
LEFT JOIN Program p ON u.id = p.user_id
LEFT JOIN Challenge c ON u.id = c.user_id
LEFT JOIN Course co ON u.id = co.user_id
LEFT JOIN Review f ON f.source_id = p.id OR f.source_id = c.id OR f.source_id = co.id
WHERE u.role_id = (SELECT setting_value FROM GetSettingValue('Role','Mentor') ) and j.name = 'UI/UX Designer'
GROUP BY u.id, u.name, u.location_id,l.name, j.name, u.role_id
ORDER BY average_rating DESC;
```
## Lay mentor theo ten company
```sql
SELECT 
    u.name,
    l.name as location,
    c.name as company,
    c.img as imgcompany,
    COALESCE(AVG(f.rating_star), 0) as average_rating
FROM [User] u
JOIN experience e ON u.id = e.user_id
JOIN company c ON e.company_id = c.id
JOIN Location l ON u.location_id = l.id
LEFT JOIN Program p ON u.id = p.user_id
LEFT JOIN Challenge ch ON u.id = ch.user_id
LEFT JOIN Course co ON u.id = co.user_id
LEFT JOIN Review f ON f.source_id = p.id OR f.source_id = ch.id OR f.source_id = co.id
WHERE c.name = 'bbv' and u.role_id = (SELECT setting_value FROM GetSettingValue('Role','Mentor') )
GROUP BY u.name, l.name, c.name, c.img;
```

## Lay theo Jobtitle, location , ten cong ty va top rating
```sql 

SELECT 
	u.id, u.name, l.name as location, u.role_id ,ca.name ,j.name as jobtitle
	,COALESCE(AVG(f.rating_star),0) as average_rating
FROM [User] u
JOIN Jobtitle j ON  u.jobtitle_id = j.id
JOIN Location l on u.location_id = l.id
JOIN experience e ON u.id = e.user_id
JOIN company ca ON e.company_id = ca.id
LEFT JOIN Program p ON u.id = p.user_id
LEFT JOIN Challenge c ON u.id = c.user_id
LEFT JOIN Course co ON u.id = co.user_id
LEFT JOIN Review f ON f.source_id = p.id OR f.source_id = c.id OR f.source_id = co.id
WHERE l.name ='Ho Chi Minh' AND u.role_id = (SELECT setting_value FROM GetSettingValue('Role','Mentor') ) AND j.name ='UI/UX Designer' AND  ca.name = 'bbv'
GROUP BY u.id, u.name, l.name, j.name, u.role_id , ca.name
ORDER BY average_rating DESC;
```