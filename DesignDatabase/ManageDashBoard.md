## Overview
```sql 
SELECT 
		(SELECT COUNT(*) FROM [User]) AS TotalUsers,
    
    (SELECT COUNT(*) FROM [User]
     WHERE MONTH(createAt) = MONTH(GETDATE()) 
       AND YEAR(createAt) = YEAR(GETDATE())) AS UsersThisMonth,
    
    ROUND(
        (
            (SELECT COUNT(*) FROM [User]
             WHERE MONTH(createAt) = MONTH(GETDATE()) 
               AND YEAR(createAt) = YEAR(GETDATE())) -
            (SELECT COUNT(*) FROM [User]
             WHERE MONTH(createAt) = MONTH(DATEADD(MONTH, -1, GETDATE())) 
               AND YEAR(createAt) = YEAR(GETDATE()))
        ) / NULLIF((SELECT COUNT(*) FROM [User] 
                    WHERE MONTH(createAt) = MONTH(DATEADD(MONTH, -1, GETDATE())) 
                      AND YEAR(createAt) = YEAR(GETDATE())), 0) * 100, 2
    ) AS PercentageChangeThisMonth,
    
    (SELECT COUNT(*) FROM [User]
     WHERE DATEPART(ISO_WEEK, createAt) = DATEPART(ISO_WEEK, GETDATE()) 
       AND YEAR(createAt) = YEAR(GETDATE())) AS UsersThisWeek,
    
    ROUND(
        (
            (SELECT COUNT(*) FROM [User] 
             WHERE DATEPART(ISO_WEEK, createAt) = DATEPART(ISO_WEEK, GETDATE()) 
               AND YEAR(createAt) = YEAR(GETDATE())) -
            (SELECT COUNT(*) FROM [User]
             WHERE DATEPART(ISO_WEEK, createAt) = DATEPART(ISO_WEEK, DATEADD(WEEK, -1, GETDATE())) 
               AND YEAR(createAt) = YEAR(GETDATE()))
        ) / NULLIF((SELECT COUNT(*) FROM [User]
                    WHERE DATEPART(ISO_WEEK, createAt) = DATEPART(ISO_WEEK, DATEADD(WEEK, -1, GETDATE())) 
                      AND YEAR(createAt) = YEAR(GETDATE())), 0) * 100, 2
    ) AS PercentageChangeThisWeek;
```

## Total
```sql
SELECT 
    -- Total Mentees
    SUM(CASE WHEN role_id = 3 THEN 1 ELSE 0 END) AS TotalMentees,
    
    -- Total Mentors
    SUM(CASE WHEN role_id = 2 THEN 1 ELSE 0 END) AS TotalMentors,
    
    -- Percentage of Mentees
    ROUND(
        (SUM(CASE WHEN role_id = 3 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2
    ) AS PercentageMentees,
    
    -- Percentage of Mentors
    ROUND(
        (SUM(CASE WHEN role_id = 2 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2
    ) AS PercentageMentors
FROM [User];
```

## Specific comparision
# Total mentor vs last month
```sql 
SELECT 
    -- Mentors This Month
    (SELECT COUNT(*) FROM [User]
     WHERE role_id = '2') AS TotalMentor,
    
    -- Percentage Change in Mentors This Month
    CASE
        WHEN (SELECT COUNT(*) FROM [User]
              WHERE role_id = '2' 
                AND MONTH(createAt) = MONTH(DATEADD(MONTH, -1, GETDATE())) 
                AND YEAR(createAt) = YEAR(GETDATE())) = 0 THEN 0
        ELSE ROUND(
            (
                (SELECT COUNT(*) FROM [User]
                 WHERE role_id = '2' 
                   AND MONTH(createAt) = MONTH(GETDATE()) 
                   AND YEAR(createAt) = YEAR(GETDATE())) -
                (SELECT COUNT(*) FROM [User]
                 WHERE role_id = '2' 
                   AND MONTH(createAt) = MONTH(DATEADD(MONTH, -1, GETDATE())) 
                   AND YEAR(createAt) = YEAR(GETDATE()))
            ) * 100.0 / NULLIF(
                (SELECT COUNT(*) FROM [User]
                 WHERE role_id = '2' 
                   AND MONTH(createAt) = MONTH(DATEADD(MONTH, -1, GETDATE())) 
                   AND YEAR(createAt) = YEAR(GETDATE())), 0), 2
        )
    END AS PercentageChangeMentorsThisMonth;
```

# Total mentor vs last week
```sql
SELECT 
    -- Total Mentors This Week
    (SELECT COUNT(*) FROM [User] 
     WHERE role_id = '2' 
       AND DATEPART(WEEK, createAt) = DATEPART(WEEK, GETDATE()) 
       AND YEAR(createAt) = YEAR(GETDATE())) AS TotalMentorsThisWeek,
       
    -- Percentage Change in Mentors This Week vs Last Week
    CASE 
        WHEN (SELECT COUNT(*) FROM [User] 
              WHERE role_id = '2' 
                AND DATEPART(WEEK, createAt) = DATEPART(WEEK, DATEADD(WEEK, -1, GETDATE())) 
                AND YEAR(createAt) = YEAR(DATEADD(WEEK, -1, GETDATE()))) = 0
        THEN 100.00
        ELSE ROUND(
            (
                (SELECT COUNT(*) FROM [User] 
                 WHERE role_id = '2' 
                   AND DATEPART(WEEK, createAt) = DATEPART(WEEK, GETDATE()) 
                   AND YEAR(createAt) = YEAR(GETDATE())) -
                (SELECT COUNT(*) FROM [User] 
                 WHERE role_id = '2' 
                   AND DATEPART(WEEK, createAt) = DATEPART(WEEK, DATEADD(WEEK, -1, GETDATE())) 
                   AND YEAR(createAt) = YEAR(DATEADD(WEEK, -1, GETDATE())))
            ) / NULLIF(
                (SELECT COUNT(*) FROM [User] 
                 WHERE role_id = '2' 
                   AND DATEPART(WEEK, createAt) = DATEPART(WEEK, DATEADD(WEEK, -1, GETDATE())) 
                   AND YEAR(createAt) = YEAR(DATEADD(WEEK, -1, GETDATE()))), 0
            ) * 100, 2)
    END AS PercentageChangeMentorsThisWeek;
```
# Total mentee vs last month
```sql
SELECT 
    -- Mentors This Month
    (SELECT COUNT(*) FROM [User]
     WHERE role_id = '3') AS TotalMentor,
    
    -- Percentage Change in Mentors This Month
    CASE
        WHEN (SELECT COUNT(*) FROM [User]
              WHERE role_id = '3' 
                AND MONTH(createAt) = MONTH(DATEADD(MONTH, -1, GETDATE())) 
                AND YEAR(createAt) = YEAR(GETDATE())) = 0 THEN 0
        ELSE ROUND(
            (
                (SELECT COUNT(*) FROM [User]
                 WHERE role_id = '3' 
                   AND MONTH(createAt) = MONTH(GETDATE()) 
                   AND YEAR(createAt) = YEAR(GETDATE())) -
                (SELECT COUNT(*) FROM [User]
                 WHERE role_id = '3' 
                   AND MONTH(createAt) = MONTH(DATEADD(MONTH, -1, GETDATE())) 
                   AND YEAR(createAt) = YEAR(GETDATE()))
            ) * 100.0 / NULLIF(
                (SELECT COUNT(*) FROM [User]
                 WHERE role_id = '3' 
                   AND MONTH(createAt) = MONTH(DATEADD(MONTH, -1, GETDATE())) 
                   AND YEAR(createAt) = YEAR(GETDATE())), 0), 2
        )
    END AS PercentageChangeMentorsThisMonth;
```
# Total mentee vs last week
```sql
SELECT 
    -- Total Mentors This Week
    (SELECT COUNT(*) FROM [User] 
     WHERE role_id = '3' 
       AND DATEPART(WEEK, createAt) = DATEPART(WEEK, GETDATE()) 
       AND YEAR(createAt) = YEAR(GETDATE())) AS TotalMentorsThisWeek,
       
    -- Percentage Change in Mentors This Week vs Last Week
    CASE 
        WHEN (SELECT COUNT(*) FROM [User] 
              WHERE role_id = '3' 
                AND DATEPART(WEEK, createAt) = DATEPART(WEEK, DATEADD(WEEK, -1, GETDATE())) 
                AND YEAR(createAt) = YEAR(DATEADD(WEEK, -1, GETDATE()))) = 0
        THEN 100.00
        ELSE ROUND(
            (
                (SELECT COUNT(*) FROM [User] 
                 WHERE role_id = '3' 
                   AND DATEPART(WEEK, createAt) = DATEPART(WEEK, GETDATE()) 
                   AND YEAR(createAt) = YEAR(GETDATE())) -
                (SELECT COUNT(*) FROM [User] 
                 WHERE role_id = '3' 
                   AND DATEPART(WEEK, createAt) = DATEPART(WEEK, DATEADD(WEEK, -1, GETDATE())) 
                   AND YEAR(createAt) = YEAR(DATEADD(WEEK, -1, GETDATE())))
            ) / NULLIF(
                (SELECT COUNT(*) FROM [User] 
                 WHERE role_id = '3' 
                   AND DATEPART(WEEK, createAt) = DATEPART(WEEK, DATEADD(WEEK, -1, GETDATE())) 
                   AND YEAR(createAt) = YEAR(DATEADD(WEEK, -1, GETDATE()))), 0
            ) * 100, 2)
    END AS PercentageChangeMentorsThisWeek;
```

## Top mentor theo rating 
```sql 
SELECT 
    u.id,
    u.name,
    u.location_id,
    j.name AS jobtitle,
    u.role_id,
    COALESCE(AVG(f.rating_star), 0) AS average_rating
FROM [User] u
JOIN Jobtitle j ON u.jobtitle_id = j.id
LEFT JOIN Program p ON u.id = p.user_id
LEFT JOIN Challenge c ON u.id = c.user_id
LEFT JOIN Course co ON u.id = co.user_id
LEFT JOIN Review f ON f.source_id = p.id OR f.source_id = c.id OR f.source_id = co.id
WHERE u.role_id = (SELECT setting_value FROM GetSettingValue('Role','Mentor') )
GROUP BY u.id, u.name, u.location_id, j.name, u.role_id
ORDER BY average_rating DESC;
```

## Top mentee theo mentor rating 
```sql
SELECT receiver_id, AVG(rating_star) AS avg_rating
FROM MentorReview
GROUP BY receiver_id
ORDER BY avg_rating DESC
```

## Thong ke theo age va gender
```sql
SELECT 
    CASE
        WHEN age BETWEEN 15 AND 20 THEN '15-20'
        WHEN age BETWEEN 21 AND 25 THEN '21-25'
        WHEN age BETWEEN 26 AND 30 THEN '26-30'
        WHEN age BETWEEN 31 AND 35 THEN '31-35'
        ELSE 'Other'
    END AS AgeGroup,
    gender,
    COUNT(*) AS Count
FROM [User]
GROUP BY 
    CASE
        WHEN age BETWEEN 15 AND 20 THEN '15-20'
        WHEN age BETWEEN 21 AND 25 THEN '21-25'
        WHEN age BETWEEN 26 AND 30 THEN '26-30'
        WHEN age BETWEEN 31 AND 35 THEN '31-35'
        ELSE 'Other'
    END,
    gender
ORDER BY AgeGroup, gender;
```
