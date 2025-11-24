-- =====================================================================
-- DAY 18: UNION and UNION ALL - PRACTICE QUESTIONS
-- Topic: UNION, UNION ALL, combining result sets
-- =====================================================================
-- PRACTICE QUESTION 1
-- Combine patient names and staff names into a single list.
-- SELECT name AS full_name, 'Patient' AS type
-- FROM patients
-- UNION ALL
-- SELECT staff_name AS full_name, 'Staff' AS type
-- FROM staff
-- ORDER BY type, full_name;



-- PRACTICE QUESTION 2
-- Union high and low satisfaction patients.
-- SELECT patient_id, name, satisfaction, 'High Satisfaction' AS category
-- FROM patients
-- WHERE satisfaction > 90
-- UNION
-- SELECT patient_id, name, satisfaction, 'Low Satisfaction' AS category
-- FROM patients
-- WHERE satisfaction < 50
-- ORDER BY satisfaction DESC;




-- PRACTICE QUESTION 3
-- List all unique names from both patients and staff.
-- SELECT DISTINCT name AS full_name
-- FROM patients
-- UNION
-- SELECT DISTINCT staff_name AS full_name
-- FROM staff
-- ORDER BY full_name;



-- ========================================================================
-- 					          DAILY CHALLENGE
-- ========================================================================
-- Create a personnel + patient combined list with identifiers, names, type, and 
-- service filtered to surgery or emergency.
SELECT 
    patient_id AS identifier,
    name AS full_name,
    'Patient' AS type,
    service
FROM patients
WHERE LOWER(service) IN ('surgery', 'emergency')
UNION ALL
SELECT 
    staff_id AS identifier,
    staff_name AS full_name,
    'Staff' AS type,
    service
FROM staff
WHERE LOWER(service) IN ('surgery', 'emergency')
ORDER BY type, service, full_name;
