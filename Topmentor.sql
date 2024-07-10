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
