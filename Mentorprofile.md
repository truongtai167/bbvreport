## lay name , jobtitle , role , totalprogram , avgrating , totalfollowers , totalstudent, totalfeedback  cua mentor
```sql
SELECT 
    u.id,
    u.name,
    j.name as jobtitle,
    u.location_id,
    u.role,
    (SELECT COUNT(*) FROM Program WHERE user_id = 'U1') as total_programs,
    (SELECT COUNT(*) FROM Feedback WHERE receiver_id = 'U1') as total_feedback,
    (SELECT COUNT(DISTINCT pu.user_id) 
     FROM Program p 
     JOIN ProgramUser pu ON p.id = pu.program_id 
     WHERE p.user_id = 'U1') as total_users_in_programs,
    (SELECT COUNT(*) 
     FROM Follow 
     WHERE followee_id = 'U1') as total_followers,
    (SELECT 
     COALESCE(AVG(f.rating),0)
     FROM Userr u
     JOIN Jobtitle j ON  u.jobtitle_id = j.id
     LEFT JOIN Program p ON u.id = p.user_id
     LEFT JOIN Feedback f ON p.id = f.program_id AND f.receiver_id = u.id
     WHERE u.id = 'U1')  as average_rating
FROM Userr u 
JOIN Jobtitle j on u.jobtitle_id = j.id
WHERE u.id = 'U1';
```

## lay tat ca program cua 1 user va avg(rating)
```sql
SELECT 
    p.id,
    p.name,
    p.price,
    AVG(f.rating) AS total_rating
FROM 
    Feedback f
JOIN 
    Program p ON f.program_id = p.id
JOIN 
    Userr sender ON f.sender_id = sender.id
JOIN 
    Userr receiver ON f.receiver_id = receiver.id
WHERE 
    p.user_id = 'U1'
    AND sender.role = 'Mentee'
    AND receiver.role = 'Mentor'
GROUP BY   
    p.id,
    p.name,
    p.price
ORDER BY 
    total_rating DESC;

```

## lay experience cua 1 user
```sql
SELECT 
    e.jobtitle,
    c.name AS company_name,
    e.type
FROM 
    Experience e
JOIN 
    Company c ON e.company_id = c.id
WHERE 
    e.user_id = 'U2'
UNION
SELECT 
    p.name AS jobtitle,
    u.name AS company_name,
    'Training' AS type
FROM 
    ProgramUser pu
JOIN 
    Program p ON pu.program_id = p.id
JOIN 
    Userr u ON p.user_id = u.id
WHERE 
    pu.user_id = 'U2';
```

## lay cert cua 1 user
```sql
SELECT c.name,c.description 
FROM Userr u
JOIN CertUser cu on u.id = cu.user_id
JOIN Cert c on cu.cert_id = c.id
WHERE u.id = 'U1'
```
## Select feedback from programs of mentor
```sql
SELECT f.rating,f.description 
FROM Feedback f
JOIN Program p on f.program_id = p.id
JOIN Userr u on p.user_id = u.id and f.receiver_id = u.id
WHERE u.id ='U1'
```

## Select skill
```sql 
Select s.name
From Skill s
JOIN UserSkill us on s.id = us.skill_id
JOIN Userr u on us.user_id = u.id
WHERE u.id ='U1'
```