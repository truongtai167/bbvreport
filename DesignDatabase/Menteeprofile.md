
## select thong tin co ban cua mentee và số lượng người mentee đang theo dõi
```sql
SELECT 
    u.id,
    u.name,
    j.name as jobtitle,
    l.name as location,
    u.role_id,
    (SELECT COUNT(*) 
     FROM FollowUser 
     WHERE followee_id = u.id) as total_followers
FROM [User] u 
JOIN Jobtitle j ON u.jobtitle_id = j.id
JOIN Location l ON u.location_id = l.id
WHERE u.id = 4 and  u.role_id = (SELECT setting_value FROM GetSettingValue('Role','Mentee') ) 
```

## lay cert cua 1 user
```sql

SELECT ci.id AS CertID, 
       ci.credentialcode, 
       ci.certified_at, 
       COALESCE(p.program_name, c.name, ch.challenge_name) AS CertName
FROM CredentialIssued ci
JOIN SourceTemplate st ON ci.sourcetemplate_id = st.id
LEFT JOIN Program p ON st.source_id = p.id AND st.sourcetype_id = '1'
LEFT JOIN Course c ON st.source_id = c.id AND st.sourcetype_id = '3'
LEFT JOIN Challenge ch ON st.source_id = ch.id AND st.sourcetype_id = '2'
WHERE ci.user_id = '3';
```

## lay experience cua 1 user
```sql
-- First part: Selecting from Experience table
SELECT 
    j.name AS jobtitle,
    c.name AS company_name,
    w.name AS type,
    e.isworking
FROM 
    Experience e
JOIN 
    Company c ON e.company_id = c.id
JOIN 
    Jobtitle j ON e.jobtitle_id = j.id
JOIN 
    WorkingType w ON e.type_id = w.id
WHERE 
    e.user_id = '2'

UNION

-- Second part: Selecting from ProgramUser and Program tables
SELECT 
    p.program_name AS jobtitle,
    u.name AS company_name,
    'Online Program' AS type,
    0 AS isworking
FROM 
    ProgramUser pu
JOIN 
    Program p ON pu.program_id = p.id
JOIN 
    [User] u ON p.user_id = u.id
WHERE 
    pu.user_id = '2' AND pu.status = 'Completed';
```
## Lay Feeedback tu mentor
```sql
SELECT m.sender_id , m.rating_star ,m.content FROM MentorReview m WHERE receiver_id = 1
```

## lay skill
```sql
Select s.name
From Skill s
JOIN UserSkill us on s.id = us.skill_id
JOIN Userr u on us.user_id = u.id
WHERE u.id ='U1'
```
## lay education 
```sql 
SELECT e.degree , u.name , u.img
 from education e
JOIN University u on e.university_id = u.id
WHERE e.user_id = 'U1'
```