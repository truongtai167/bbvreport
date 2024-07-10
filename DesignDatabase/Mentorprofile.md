## lay name , jobtitle , role , totalprogram , avgrating , totalfollowers , totalstudent, totalfeedback  cua mentor
```sql
SELECT 
    u.id,
    u.name,
    j.name AS jobtitle,
    u.location_id,
    u.role_id,
    (SELECT COUNT(*) FROM Program WHERE user_id = u.id) AS total_programs,
    (SELECT COUNT(*) FROM (
         SELECT fm.id
         FROM Review fm
         LEFT JOIN Program p ON fm.source_id = p.id AND p.user_id = u.id
         LEFT JOIN Challenge c ON fm.source_id = c.id AND c.user_id = u.id
         LEFT JOIN Course co ON fm.source_id = co.id AND co.user_id = u.id
         WHERE p.user_id = u.id OR c.user_id = u.id OR co.user_id = u.id
         ) AS feedback_count
     ) AS total_feedback,
    (SELECT COUNT(DISTINCT pu.user_id) 
     FROM Program p 
     JOIN ProgramUser pu ON p.id = pu.program_id 
     WHERE p.user_id = u.id
     ) AS total_students_from_programs,
    (SELECT COUNT(DISTINCT cu.user_id)
     FROM Challenge c 
     JOIN ChallengeUser cu ON c.id = cu.challenge_id
     WHERE c.user_id = u.id
     ) AS total_students_from_challenges,
    (SELECT COUNT(*) FROM FollowUser WHERE followee_id = u.id) AS total_followers,
    (SELECT COALESCE(AVG(fm.rating_star), 0)
     FROM Review fm
     LEFT JOIN Program p ON fm.source_id = p.id AND p.user_id = u.id
     LEFT JOIN Challenge c ON fm.source_id = c.id AND c.user_id = u.id
     LEFT JOIN Course co ON fm.source_id = co.id AND co.user_id = u.id
     WHERE p.user_id = u.id OR c.user_id = u.id OR co.user_id = u.id
     ) AS average_rating
FROM [User] u 
JOIN Jobtitle j ON u.jobtitle_id = j.id
WHERE u.id = '1';

```

## lay tat ca program cua 1 user va avg(rating)
```sql
SELECT 
    p.id,
    p.program_name,
	p.description,
    p.price,
    AVG(f.rating_star) AS total_rating
FROM 
    Review f
JOIN 
    Program p ON f.source_id = p.id
JOIN 
    [User] sender ON f.user_id = sender.id
WHERE 
    p.user_id = '5'
GROUP BY   
    p.id,
    p.program_name,
	p.description,
    p.price
ORDER BY 
    total_rating DESC;
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
## Select tat ca feedback tu course , challenge , program of mentor
```sql
SELECT 
    fm.user_id,
    fm.rating_star, 
    fm.content,
    CASE 
        WHEN P.program_name IS NOT NULL THEN CONCAT('Program: ', P.program_name)
        WHEN C.challenge_name IS NOT NULL THEN CONCAT('Challenge: ', C.challenge_name)
        WHEN CO.name IS NOT NULL THEN CONCAT('Course: ', CO.name)
    END AS name
FROM Review FM
LEFT JOIN Program P ON FM.source_id = P.id AND fm.source_type_id = '3'
LEFT JOIN Challenge C ON FM.source_id = C.id AND fm.source_type_id = '2'
LEFT JOIN Course CO ON FM.source_id = CO.id AND fm.source_type_id = '1'
WHERE 
    P.user_id = '2' OR 
    C.user_id = '2' OR 
    CO.user_id = '2';
```
## Select skill
```sql 
Select s.name from UserSkill u
JOIN Skill s on u.skill_id = s.id
WHERE user_id = 1
```
## lay education cua 1 user
```sql
SELECT un.name,un.img, u.degree FROM Education u 
JOIN University un on u.university_id = un.id
WHERE user_id = 1
```
## Select TOP MENTOR
```sql
WITH avg_rating AS (
    -- Calculate average rating for each user
    SELECT 
        u.id AS user_id,
        (
            SELECT COALESCE(AVG(fm.rating_star), 0)
            FROM Review fm
            LEFT JOIN Program p ON fm.source_id = p.id AND p.user_id = u.id
            LEFT JOIN Challenge c ON fm.source_id = c.id AND c.user_id = u.id
            LEFT JOIN Course co ON fm.source_id = co.id AND co.user_id = u.id
            WHERE p.user_id = u.id OR c.user_id = u.id OR co.user_id = u.id
        ) AS average_rating
    FROM 
        [User] u 
    JOIN 
        Jobtitle j ON u.jobtitle_id = j.id
),

abc AS (
    -- Calculate completion percentage for each program
    SELECT 
        p.user_id,
        p.id, 
        COUNT(*) AS total_count,
        SUM(CASE WHEN pu.status = 'Completed' THEN 1 ELSE 0 END) AS completed_count,
        ROUND(
            (SUM(CASE WHEN pu.status = 'Completed' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 
            2
        ) AS completion_percentage
    FROM 
        ProgramUser pu
    JOIN 
        Program p ON pu.program_id = p.id
    GROUP BY 
        p.user_id,
        p.id
),

avg_comple AS (
    -- Calculate average completion percentage for each user
    SELECT 
        user_id,
        AVG(completion_percentage) AS average_completion_percentage
    FROM 
        abc
    GROUP BY 
        user_id
)

-- Combine average completion percentage and average rating, calculate weighted score, and select top 5
SELECT 
    TOP 5 
    a.user_id,
    (average_completion_percentage * 0.5) + (b.average_rating * 0.5) AS weighted_score
FROM 
    avg_comple a 
JOIN 
    avg_rating b ON a.user_id = b.user_id
ORDER BY 
    weighted_score DESC;
```

## Select Role
```sql
SELECT * FROM [User]  u
WHERE u.id = 2 and u.role_id = (SELECT setting_value FROM GetSettingValue('Role','Mentor') )
```

## Select Category
```sql
SELECT c.name from Program p
JOIN Category c on p.category_id = c.id
WHERE p.user_id = 2
```
