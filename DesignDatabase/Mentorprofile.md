## lay name , jobtitle , role , totalprogram , avgrating , totalfollowers , totalstudent, totalfeedback  cua mentor
```sql
SELECT 
    u.id,
    u.name,
    j.name as jobtitle,
    u.location_id,
    u.role_id,
    (SELECT COUNT(*) 
     FROM Program 
     WHERE mentor_id = 'U1') as total_programs,
    (SELECT COUNT(*)
     FROM Review fm
     LEFT JOIN Program p ON fm.receiver_id = p.id
     LEFT JOIN Challenge c ON fm.receiver_id = c.id
     LEFT JOIN Course co ON fm.receiver_id = co.id
     WHERE p.mentor_id = 'U1' OR c.mentor_id = 'U1' OR co.mentor_id = 'U1') as total_feedback,
    (SELECT COUNT(DISTINCT pu.user_id) 
     FROM Program p 
     JOIN ProgramUser pu ON p.id = pu.program_id 
     WHERE p.mentor_id = 'U1') as total_users_in_programs,
    (SELECT COUNT(*) 
     FROM Follow 
     WHERE followee_id = 'U1') as total_followers,
    (SELECT 
     COALESCE(AVG(fm.rating),0)
     FROM Review fm
     LEFT JOIN Program p ON fm.receiver_id = p.id
     LEFT JOIN Challenge c ON fm.receiver_id = c.id
     LEFT JOIN Course co ON fm.receiver_id = co.id
     WHERE p.mentor_id = 'U1' OR c.mentor_id = 'U1' OR co.mentor_id = 'U1') as average_rating
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
    Review f
JOIN 
    Program p ON f.receiver_id = p.id
JOIN 
    Userr sender ON f.sender_id = sender.id
WHERE 
    p.mentor_id = 'U2'
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
    j.name as jobtitle,
    c.name AS company_name,
    e.type
FROM 
    Experience e
JOIN 
    Company c ON e.company_id = c.id
JOIN 
	Jobtitle j on e.jobtitle_id = j.id
WHERE 
    e.user_id = 'U4'
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
    Userr u ON p.mentor_id = u.id
WHERE 
    pu.user_id = 'U4' and pu.status ='Completed';

```

## lay cert cua 1 user
```sql
SELECT ci.id AS CertID, 
       ci.credentialcode, 
       ci.certified_at, 
       COALESCE(p.name, c.name, ch.name) AS CertName
FROM CredentialIssued ci
JOIN SourceTemplate st ON ci.sourcetemplate_id = st.id
LEFT JOIN Program p ON st.source_id = p.id AND st.sourcetype_id = 'S3'
LEFT JOIN Course c ON st.source_id = c.id AND st.sourcetype_id = 'S1'
LEFT JOIN Challenge ch ON st.source_id = ch.id AND st.sourcetype_id = 'S2'
WHERE ci.user_id = 'U3';
```
## Select tat ca feedback tu course , challenge , program of mentor
```sql
SELECT 
    fm.sender_id,
    fm.rating, 
    fm.content,
    CASE 
        WHEN P.name IS NOT NULL THEN CONCAT('Program: ', P.name)
        WHEN C.name IS NOT NULL THEN CONCAT('Challenge: ', C.name)
        WHEN CO.name IS NOT NULL THEN CONCAT('Course: ', CO.name)
    END AS name
FROM Review FM
LEFT JOIN Program P ON FM.receiver_id = P.id AND fm.sourcetype_id = 'S3'
LEFT JOIN Challenge C ON FM.receiver_id = C.id AND fm.sourcetype_id = 'S2'
LEFT JOIN Course CO ON FM.receiver_id = CO.id AND fm.sourcetype_id = 'S1'
WHERE 
    P.mentor_id = 'U2' OR 
    C.mentor_id = 'U2' OR 
    CO.mentor_id = 'U2';
```
## Select skill
```sql 
Select s.name
From Skill s
JOIN UserSkill us on s.id = us.skill_id
JOIN Userr u on us.user_id = u.id
WHERE u.id ='U1'
```
## lay education cua 1 user
SELECT e.degree , u.name , u.img
 from education e
JOIN University u on e.university_id = u.id
WHERE e.user_id = 'U1'

