# lay tat ca location 
```sql
SELECT name from location
```
## hien thi thong tin mentor len trang chinh
```sql 
SELECT 
    u.id,
    u.name,
    u.location_id,
    j.name AS jobtitle,
    u.role_id,
    COALESCE(AVG(f.rating), 0) AS average_rating
FROM Userr u
JOIN Jobtitle j ON u.jobtitle_id = j.id
LEFT JOIN Program p ON u.id = p.mentor_id
LEFT JOIN Challenge c ON u.id = c.mentor_id
LEFT JOIN Course co ON u.id = co.mentor_id
LEFT JOIN Review f ON f.receiver_id = p.id OR f.receiver_id = c.id OR f.receiver_id = co.id
WHERE u.role_id = 'R1'
GROUP BY u.id, u.name, u.location_id, j.name, u.role_id
```
## lay mentor rating theo location va top rating
```sql
SELECT 
	u.id, u.name, l.name as location, u.role_id , j.name as jobtitle
	,COALESCE(AVG(f.rating),0) as average_rating
FROM Userr u
JOIN Jobtitle j ON  u.jobtitle_id = j.id
JOIN Location l on u.location_id = l.id
LEFT JOIN Program p ON u.id = p.mentor_id
LEFT JOIN Challenge c ON u.id = c.mentor_id
LEFT JOIN Course co ON u.id = co.mentor_id
LEFT JOIN Review f ON f.receiver_id = p.id OR f.receiver_id = c.id OR f.receiver_id = co.id
WHERE l.name ='Ho Chi Minh' AND u.role_id = 'R1'
GROUP BY u.id, u.name, location, jobtitle, u.role_id
ORDER BY average_rating DESC;
```
## Lay mentor theo top rating (program , challenges , course)
```sql
SELECT 
    u.id,
    u.name,
    u.location_id,
    j.name AS jobtitle,
    u.role_id,
    COALESCE(AVG(f.rating), 0) AS average_rating
FROM Userr u
JOIN Jobtitle j ON u.jobtitle_id = j.id
LEFT JOIN Program p ON u.id = p.mentor_id
LEFT JOIN Challenge c ON u.id = c.mentor_id
LEFT JOIN Course co ON u.id = co.mentor_id
LEFT JOIN Review f ON f.receiver_id = p.id OR f.receiver_id = c.id OR f.receiver_id = co.id
WHERE u.role_id = 'R1'
GROUP BY u.id, u.name, u.location_id, j.name, u.role_id
ORDER BY average_rating DESC;
```
## Lay mentor theo jobtitle va top rating
```sql
SELECT 
	u.id, u.name, u.location_id, j.name as jobtitle, u.role_id
	,COALESCE(AVG(f.rating),0) as average_rating
FROM Userr u
JOIN Jobtitle j ON  u.jobtitle_id = j.id
LEFT JOIN Program p ON u.id = p.mentor_id
LEFT JOIN Challenge c ON u.id = c.mentor_id
LEFT JOIN Course co ON u.id = co.mentor_id
LEFT JOIN Review f ON f.receiver_id = p.id OR f.receiver_id = c.id OR f.receiver_id = co.id
WHERE u.role_id = 'R1' and j.name = 'Senior Software Engineaer'
GROUP BY u.id, u.name, u.location_id, j.name, u.role_id
ORDER BY average_rating DESC;
```