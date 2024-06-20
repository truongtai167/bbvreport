## lay mentor rating theo location va top rating
```sql
SELECT 
	u.id, u.name, l.name as location, u.role , j.name as jobtitle
	,COALESCE(AVG(f.rating),0) as average_rating
FROM Userr u
JOIN Jobtitle j ON  u.jobtitle_id = j.id
JOIN Location l on u.location_id = l.id
LEFT JOIN Program p ON u.id = p.user_id
LEFT JOIN Feedback f ON p.id = f.program_id AND f.receiver_id = u.id
WHERE u.location_id = 'L1' AND u.role = 'Mentor'
GROUP BY u.id, u.name, location, jobtitle, u.role
ORDER BY average_rating DESC;
```
## Lay mentor theo top rating
```sql
SELECT 
	u.id, u.name, u.location_id, j.name as jobtitle, u.role
	,COALESCE(AVG(f.rating),0) as average_rating
FROM Userr u
JOIN Jobtitle j ON  u.jobtitle_id = j.id
LEFT JOIN Program p ON u.id = p.user_id
LEFT JOIN Feedback f ON p.id = f.program_id AND f.receiver_id = u.id
WHERE u.role = 'Mentor'
GROUP BY u.id, u.name, u.location_id, j.name, u.role
ORDER BY average_rating DESC;
```
## Lay mentor theo jobtitle va top rating
```sql
SELECT 
	u.id, u.name, u.location_id, j.name as jobtitle, u.role
	,COALESCE(AVG(f.rating),0) as average_rating
FROM Userr u
JOIN Jobtitle j ON  u.jobtitle_id = j.id
LEFT JOIN Program p ON u.id = p.user_id
LEFT JOIN Feedback f ON p.id = f.program_id AND f.receiver_id = u.id
WHERE u.role = 'Mentor' and j.name = 'Senior Software Engineer'
GROUP BY u.id, u.name, u.location_id, j.name, u.role
ORDER BY average_rating DESC;
```