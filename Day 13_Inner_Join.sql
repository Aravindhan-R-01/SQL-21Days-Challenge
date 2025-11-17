-- ===================================================================
-- DAY 13: INNER JOIN - PRACTICE QUESTIONS
-- Topics: INNER JOIN, joining two tables, relationship understanding
-- ===================================================================

-- PRACTICE QUESTION 1
-- Join patients and staff based on common service, showing matching patient & staff.
-- SELECT 
--     p.patient_id, p.name AS patient_name, p.service,
--     s.staff_id, s.staff_name, s.role
-- FROM patients p
-- INNER JOIN staff s 
--     ON p.service = s.service
-- ORDER BY p.service, p.name;


-- PRACTICE QUESTION 2
-- Join services_weekly with staff to show weekly service data with staff info.
-- SELECT 
--     sw.week,
--     sw.service,
--     sw.patients_admitted,
--     sw.patients_refused,
--     sw.patient_satisfaction,
--     s.staff_id,
--     s.staff_name,
--     s.role
-- FROM services_weekly sw
-- INNER JOIN staff s
--     ON sw.service = s.service
-- ORDER BY sw.week, sw.service;



-- PRACTICE QUESTION 3
-- Report showing patient info + staff assigned to their service.
-- SELECT
--     p.patient_id,
--     p.name AS patient_name,
--     p.age,
--     p.service,
--     s.staff_name,
--     s.role
-- FROM patients p
-- INNER JOIN staff s
--     ON p.service = s.service
-- ORDER BY p.patient_id;


-- =====================================================
-- 						DAILY CHALLENGE
-- =====================================================
-- Show patient_id, patient name, age, service, and number of staff in that service.
-- Only include services having more than 5 staff members.
-- Order by staff_count DESC, then patient_name.
SELECT
    p.patient_id,
    p.name AS patient_name,
    p.age,
    p.service,
    COUNT(s.staff_id) AS staff_count
FROM patients p
INNER JOIN staff s
    ON p.service = s.service
GROUP BY 
    p.patient_id, p.name, p.age, p.service
HAVING COUNT(s.staff_id) > 5
ORDER BY staff_count DESC, patient_name ASC;
