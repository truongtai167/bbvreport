## 
```sql
SELECT 
    -- Total Users
    (SELECT COUNT(*) FROM Userr) AS TotalUsers,
    
    -- Users This Month
    (SELECT COUNT(*) FROM Userr
     WHERE MONTH(createAt) = MONTH(CURRENT_DATE) 
       AND YEAR(createAt) = YEAR(CURRENT_DATE)) AS UsersThisMonth,
    
    -- Percentage Change This Month
    ROUND(
        ((SELECT COUNT(*) FROM Userr
          WHERE MONTH(createAt) = MONTH(CURRENT_DATE) 
            AND YEAR(createAt) = YEAR(CURRENT_DATE)) -
         (SELECT COUNT(*) FROM Userr
          WHERE MONTH(createAt) = MONTH(CURRENT_DATE) - 1 
            AND YEAR(createAt) = YEAR(CURRENT_DATE))
        ) / (SELECT COUNT(*) FROM Userr 
             WHERE MONTH(createAt) = MONTH(CURRENT_DATE) - 1 
               AND YEAR(createAt) = YEAR(CURRENT_DATE)) * 100, 2
    ) AS PercentageChangeThisMonth,
    
    -- Users This Week
    (SELECT COUNT(*) FROM Userr
     WHERE YEARWEEK(createAt, 1) = YEARWEEK(CURRENT_DATE, 1)) AS UsersThisWeek,
    
    -- Percentage Change This Week
    ROUND(
        ((SELECT COUNT(*) FROM Userr 
          WHERE YEARWEEK(createAt, 1) = YEARWEEK(CURRENT_DATE, 1)) -
         (SELECT COUNT(*) FROM Userr
          WHERE YEARWEEK(createAt, 1) = YEARWEEK(CURRENT_DATE, 1) - 1)
        ) / (SELECT COUNT(*) FROM Userr
             WHERE YEARWEEK(createAt, 1) = YEARWEEK(CURRENT_DATE, 1) - 1) * 100, 2
    ) AS PercentageChangeThisWeek;

```

## Select total mentor and mentor this month vs last month
```sql
SELECT 
    -- Mentors This Month
    (SELECT COUNT(*) FROM Userr
     WHERE role_id = 'R1' 
     ) AS TotalMentor,
    
    -- Percentage Change in Mentors This Month
    ROUND(
        (
            (SELECT COUNT(*) FROM Userr
             WHERE role_id = 'R1' 
               AND MONTH(createAt) = MONTH(CURRENT_DATE) 
               AND YEAR(createAt) = YEAR(CURRENT_DATE)) -
            (SELECT COUNT(*) FROM Userr
             WHERE role_id = 'R1' 
               AND MONTH(createAt) = MONTH(CURRENT_DATE) - 1 
               AND YEAR(createAt) = YEAR(CURRENT_DATE))
        ) / NULLIF(
            (SELECT COUNT(*) FROM Userr
             WHERE role_id = 'R1' 
               AND MONTH(createAt) = MONTH(CURRENT_DATE) - 1 
               AND YEAR(createAt) = YEAR(CURRENT_DATE)), 0
        ) * 100, 2
    ) AS PercentageChangeMentorsThisMonth;
```

## Select total mentee and mentee this month vs last month
```sql
SELECT 
    -- Mentors This Month
    (SELECT COUNT(*) FROM Userr
     WHERE role_id = 'R2' 
     ) AS TotalMentor,
    
    -- Percentage Change in Mentors This Month
    ROUND(
        (
            (SELECT COUNT(*) FROM Userr
             WHERE role_id = 'R2' 
               AND MONTH(createAt) = MONTH(CURRENT_DATE) 
               AND YEAR(createAt) = YEAR(CURRENT_DATE)) -
            (SELECT COUNT(*) FROM Userr
             WHERE role_id = 'R2' 
               AND MONTH(createAt) = MONTH(CURRENT_DATE) - 1 
               AND YEAR(createAt) = YEAR(CURRENT_DATE))
        ) / NULLIF(
            (SELECT COUNT(*) FROM Userr
             WHERE role_id = 'R2' 
               AND MONTH(createAt) = MONTH(CURRENT_DATE) - 1 
               AND YEAR(createAt) = YEAR(CURRENT_DATE)), 0
        ) * 100, 2
    ) AS PercentageChangeMentorsThisMonth;
```




## Select total mentor and mentor this week vs last week
```sql

SELECT 
    -- Total Mentors This Week
    (SELECT COUNT(*) FROM Userr
     WHERE role_id = 'R1' 
       AND WEEK(createAt, 1) = WEEK(CURRENT_DATE, 1) 
       AND YEAR(createAt) = YEAR(CURRENT_DATE)) AS TotalMentorsThisWeek,
       
    -- Percentage Change in Mentors This Week vs Last Week
    CASE 
        WHEN (SELECT COUNT(*) FROM Userr
              WHERE role_id = 'R1' 
                AND WEEK(createAt, 1) = WEEK(CURRENT_DATE - INTERVAL 1 WEEK, 1) 
                AND YEAR(createAt) = YEAR(CURRENT_DATE - INTERVAL 1 WEEK)) = 0
        THEN 100.00
        ELSE ROUND(
            (
                (SELECT COUNT(*) FROM Userr 
                 WHERE role_id = 'R1' 
                   AND WEEK(createAt, 1) = WEEK(CURRENT_DATE, 1) 
                   AND YEAR(createAt) = YEAR(CURRENT_DATE)) -
                (SELECT COUNT(*) FROM Userr
                 WHERE role_id = 'R1' 
                   AND WEEK(createAt, 1) = WEEK(CURRENT_DATE - INTERVAL 1 WEEK, 1) 
                   AND YEAR(createAt) = YEAR(CURRENT_DATE - INTERVAL 1 WEEK))
            ) / NULLIF(
                (SELECT COUNT(*) FROM Userr
                 WHERE role_id = 'R1' 
                   AND WEEK(createAt, 1) = WEEK(CURRENT_DATE - INTERVAL 1 WEEK, 1) 
                   AND YEAR(createAt) = YEAR(CURRENT_DATE - INTERVAL 1 WEEK)), 0
            ) * 100, 2)
    END AS PercentageChangeMentorsThisWeek;
```




## Select total mentee and mentee this week vs last week
SELECT 
    -- Total Mentors This Week
    (SELECT COUNT(*) FROM Userr 
     WHERE role_id = 'R2' 
       AND WEEK(createAt, 1) = WEEK(CURRENT_DATE, 1) 
       AND YEAR(createAt) = YEAR(CURRENT_DATE)) AS TotalMentorsThisWeek,
       
    -- Percentage Change in Mentors This Week vs Last Week
    CASE 
        WHEN (SELECT COUNT(*) FROM Userr2 
              WHERE role_id = 'R2' 
                AND WEEK(createAt, 1) = WEEK(CURRENT_DATE - INTERVAL 1 WEEK, 1) 
                AND YEAR(createAt) = YEAR(CURRENT_DATE - INTERVAL 1 WEEK)) = 0
        THEN 100.00
        ELSE ROUND(
            (
                (SELECT COUNT(*) FROM Userr 
                 WHERE role_id = 'R2' 
                   AND WEEK(createAt, 1) = WEEK(CURRENT_DATE, 1) 
                   AND YEAR(createAt) = YEAR(CURRENT_DATE)) -
                (SELECT COUNT(*) FROM Userr
                 WHERE role_id = 'R2' 
                   AND WEEK(createAt, 1) = WEEK(CURRENT_DATE - INTERVAL 1 WEEK, 1) 
                   AND YEAR(createAt) = YEAR(CURRENT_DATE - INTERVAL 1 WEEK))
            ) / NULLIF(
                (SELECT COUNT(*) FROM Userr
                 WHERE role_id = 'R2' 
                   AND WEEK(createAt, 1) = WEEK(CURRENT_DATE - INTERVAL 1 WEEK, 1) 
                   AND YEAR(createAt) = YEAR(CURRENT_DATE - INTERVAL 1 WEEK)), 0
            ) * 100, 2)
    END AS PercentageChangeMentorsThisWeek;

## Select mentee by age and gender

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
FROM Userr u
WHERE u.role_id = 'R2'
GROUP BY AgeGroup, gender
ORDER BY AgeGroup, gender;
