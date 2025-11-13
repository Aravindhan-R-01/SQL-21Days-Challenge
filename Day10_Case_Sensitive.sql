-- =====================================================
-- DAY 10: CASE STATEMENTS - PRACTICE QUESTIONS
-- Topic: CASE WHEN, conditional logic, derived columns
-- =====================================================

-- PRACTICE QUESTION 1
-- Categorise patients as 'High', 'Medium', or 'Low' satisfaction based on their scores

-- SELECT
--     patient_id,
--     name,
--     satisfaction,
--     CASE
--         WHEN satisfaction >= 80 THEN 'High'
--         WHEN satisfaction >= 60 THEN 'Medium'
--         ELSE 'Low'
--     END AS satisfaction_category
-- FROM patients
-- ORDER BY satisfaction DESC;


-- PRACTICE QUESTION 2
-- Label staff roles as 'Medical' or 'Support' based on role type

-- SELECT
--     staff_id,
--     staff_name,
--     role,
--     CASE
--         WHEN role IN ('Doctor', 'Nurse', 'Surgeon') THEN 'Medical'
--         ELSE 'Support'
--     END AS staff_category
-- FROM staff
-- ORDER BY staff_category, role;


-- PRACTICE QUESTION 3
-- Create age groups for patients (0-18, 19-40, 41-65, 65+)

-- SELECT
--     patient_id,
--     name,
--     age,
--     CASE
--         WHEN age < 18 THEN '0-18'
--         WHEN age BETWEEN 18 AND 40 THEN '19-40'
--         WHEN age BETWEEN 41 AND 65 THEN '41-65'
--         ELSE '65+'
--     END AS age_group
-- FROM patients
-- ORDER BY age;


-- =====================================================
-- DAILY CHALLENGE
-- =====================================================

-- Create a service performance report showing service name, 
-- total patients admitted, and a performance category based on:
-- 'Excellent' if avg satisfaction >= 85
-- 'Good' if >= 75
-- 'Fair' if >= 65
-- Otherwise 'Needs Improvement'
-- Order by average satisfaction descending

SELECT
    p.service,
    COUNT(p.patient_id) AS total_patients_admitted,
    ROUND(AVG(p.satisfaction), 2) AS avg_satisfaction,
    CASE
        WHEN AVG(p.satisfaction) >= 85 THEN 'Excellent'
        WHEN AVG(p.satisfaction) >= 75 THEN 'Good'
        WHEN AVG(p.satisfaction) >= 65 THEN 'Fair'
        ELSE 'Needs Improvement'
    END AS performance_category
FROM patients p
GROUP BY p.service
ORDER BY avg_satisfaction DESC;
