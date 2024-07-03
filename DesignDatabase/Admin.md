## 
```sql
SELECT 
    (SELECT COUNT(*) FROM Userr) AS TotalUsers,
    
    (SELECT COUNT(*) FROM Userr
     WHERE MONTH(createAt) = MONTH(GETDATE()) 
       AND YEAR(createAt) = YEAR(GETDATE())) AS UsersThisMonth,
    
    ROUND(
        (
            (SELECT COUNT(*) FROM Userr
             WHERE MONTH(createAt) = MONTH(GETDATE()) 
               AND YEAR(createAt) = YEAR(GETDATE())) -
            (SELECT COUNT(*) FROM Userr
             WHERE MONTH(createAt) = MONTH(DATEADD(MONTH, -1, GETDATE())) 
               AND YEAR(createAt) = YEAR(GETDATE()))
        ) / NULLIF((SELECT COUNT(*) FROM Userr 
                    WHERE MONTH(createAt) = MONTH(DATEADD(MONTH, -1, GETDATE())) 
                      AND YEAR(createAt) = YEAR(GETDATE())), 0) * 100, 2
    ) AS PercentageChangeThisMonth,
    
    (SELECT COUNT(*) FROM Userr
     WHERE DATEPART(ISO_WEEK, createAt) = DATEPART(ISO_WEEK, GETDATE()) 
       AND YEAR(createAt) = YEAR(GETDATE())) AS UsersThisWeek,
    
    ROUND(
        (
            (SELECT COUNT(*) FROM Userr 
             WHERE DATEPART(ISO_WEEK, createAt) = DATEPART(ISO_WEEK, GETDATE()) 
               AND YEAR(createAt) = YEAR(GETDATE())) -
            (SELECT COUNT(*) FROM Userr
             WHERE DATEPART(ISO_WEEK, createAt) = DATEPART(ISO_WEEK, DATEADD(WEEK, -1, GETDATE())) 
               AND YEAR(createAt) = YEAR(GETDATE()))
        ) / NULLIF((SELECT COUNT(*) FROM Userr
                    WHERE DATEPART(ISO_WEEK, createAt) = DATEPART(ISO_WEEK, DATEADD(WEEK, -1, GETDATE())) 
                      AND YEAR(createAt) = YEAR(GETDATE())), 0) * 100, 2
    ) AS PercentageChangeThisWeek;


```

## Select total mentor and mentor this month vs last month
```sql
SELECT 
    -- Mentors This Month
    (SELECT COUNT(*) FROM Userr
     WHERE role_id = 'R1') AS TotalMentor,
    
    -- Percentage Change in Mentors This Month
    CASE
        WHEN (SELECT COUNT(*) FROM Userr
              WHERE role_id = 'R1' 
                AND MONTH(createAt) = MONTH(DATEADD(MONTH, -1, GETDATE())) 
                AND YEAR(createAt) = YEAR(GETDATE())) = 0 THEN 0
        ELSE ROUND(
            (
                (SELECT COUNT(*) FROM Userr
                 WHERE role_id = 'R1' 
                   AND MONTH(createAt) = MONTH(GETDATE()) 
                   AND YEAR(createAt) = YEAR(GETDATE())) -
                (SELECT COUNT(*) FROM Userr
                 WHERE role_id = 'R1' 
                   AND MONTH(createAt) = MONTH(DATEADD(MONTH, -1, GETDATE())) 
                   AND YEAR(createAt) = YEAR(GETDATE()))
            ) * 100.0 / NULLIF(
                (SELECT COUNT(*) FROM Userr
                 WHERE role_id = 'R1' 
                   AND MONTH(createAt) = MONTH(DATEADD(MONTH, -1, GETDATE())) 
                   AND YEAR(createAt) = YEAR(GETDATE())), 0), 2
        )
    END AS PercentageChangeMentorsThisMonth;
```

## Select total mentee and mentee this month vs last month
```sql
SELECT 
    -- Mentors This Month
    (SELECT COUNT(*) FROM Userr
     WHERE role_id = 'R2') AS TotalMentor,
    
    -- Percentage Change in Mentors This Month
    CASE
        WHEN (SELECT COUNT(*) FROM Userr
              WHERE role_id = 'R2' 
                AND MONTH(createAt) = MONTH(DATEADD(MONTH, -1, GETDATE())) 
                AND YEAR(createAt) = YEAR(GETDATE())) = 0 THEN 0
        ELSE ROUND(
            (
                (SELECT COUNT(*) FROM Userr
                 WHERE role_id = 'R2' 
                   AND MONTH(createAt) = MONTH(GETDATE()) 
                   AND YEAR(createAt) = YEAR(GETDATE())) -
                (SELECT COUNT(*) FROM Userr
                 WHERE role_id = 'R2' 
                   AND MONTH(createAt) = MONTH(DATEADD(MONTH, -1, GETDATE())) 
                   AND YEAR(createAt) = YEAR(GETDATE()))
            ) * 100.0 / NULLIF(
                (SELECT COUNT(*) FROM Userr
                 WHERE role_id = 'R2' 
                   AND MONTH(createAt) = MONTH(DATEADD(MONTH, -1, GETDATE())) 
                   AND YEAR(createAt) = YEAR(GETDATE())), 0), 2
        )
    END AS PercentageChangeMentorsThisMonth;
```




## Select total mentor and mentor this week vs last week
```sql

SELECT 
    -- Total Mentors This Week
    (SELECT COUNT(*) FROM Userr 
     WHERE role_id = 'R1' 
       AND DATEPART(WEEK, createAt) = DATEPART(WEEK, GETDATE()) 
       AND YEAR(createAt) = YEAR(GETDATE())) AS TotalMentorsThisWeek,
       
    -- Percentage Change in Mentors This Week vs Last Week
    CASE 
        WHEN (SELECT COUNT(*) FROM Userr 
              WHERE role_id = 'R1' 
                AND DATEPART(WEEK, createAt) = DATEPART(WEEK, DATEADD(WEEK, -1, GETDATE())) 
                AND YEAR(createAt) = YEAR(DATEADD(WEEK, -1, GETDATE()))) = 0
        THEN 100.00
        ELSE ROUND(
            (
                (SELECT COUNT(*) FROM Userr 
                 WHERE role_id = 'R1' 
                   AND DATEPART(WEEK, createAt) = DATEPART(WEEK, GETDATE()) 
                   AND YEAR(createAt) = YEAR(GETDATE())) -
                (SELECT COUNT(*) FROM Userr 
                 WHERE role_id = 'R1' 
                   AND DATEPART(WEEK, createAt) = DATEPART(WEEK, DATEADD(WEEK, -1, GETDATE())) 
                   AND YEAR(createAt) = YEAR(DATEADD(WEEK, -1, GETDATE())))
            ) / NULLIF(
                (SELECT COUNT(*) FROM Userr 
                 WHERE role_id = 'R1' 
                   AND DATEPART(WEEK, createAt) = DATEPART(WEEK, DATEADD(WEEK, -1, GETDATE())) 
                   AND YEAR(createAt) = YEAR(DATEADD(WEEK, -1, GETDATE()))), 0
            ) * 100, 2)
    END AS PercentageChangeMentorsThisWeek;
```




## Select total mentee and mentee this week vs last week
```sql
SELECT 
    -- Total Mentors This Week
    (SELECT COUNT(*) FROM Userr 
     WHERE role_id = 'R2' 
       AND DATEPART(WEEK, createAt) = DATEPART(WEEK, GETDATE()) 
       AND YEAR(createAt) = YEAR(GETDATE())) AS TotalMentorsThisWeek,
       
    -- Percentage Change in Mentors This Week vs Last Week
    CASE 
        WHEN (SELECT COUNT(*) FROM Userr 
              WHERE role_id = 'R2' 
                AND DATEPART(WEEK, createAt) = DATEPART(WEEK, DATEADD(WEEK, -1, GETDATE())) 
                AND YEAR(createAt) = YEAR(DATEADD(WEEK, -1, GETDATE()))) = 0
        THEN 100.00
        ELSE ROUND(
            (
                (SELECT COUNT(*) FROM Userr 
                 WHERE role_id = 'R2' 
                   AND DATEPART(WEEK, createAt) = DATEPART(WEEK, GETDATE()) 
                   AND YEAR(createAt) = YEAR(GETDATE())) -
                (SELECT COUNT(*) FROM Userr 
                 WHERE role_id = 'R2' 
                   AND DATEPART(WEEK, createAt) = DATEPART(WEEK, DATEADD(WEEK, -1, GETDATE())) 
                   AND YEAR(createAt) = YEAR(DATEADD(WEEK, -1, GETDATE())))
            ) / NULLIF(
                (SELECT COUNT(*) FROM Userr 
                 WHERE role_id = 'R2' 
                   AND DATEPART(WEEK, createAt) = DATEPART(WEEK, DATEADD(WEEK, -1, GETDATE())) 
                   AND YEAR(createAt) = YEAR(DATEADD(WEEK, -1, GETDATE()))), 0
            ) * 100, 2)
    END AS PercentageChangeMentorsThisWeek;

```

## Select mentee by age and gender
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
FROM Userr
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
