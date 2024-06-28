
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