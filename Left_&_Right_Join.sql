-- ===========================================================
-- DAY 14: 𝑳𝑬𝑭𝑻 & 𝑹𝑰𝑮𝑯𝑻 𝑱𝑶𝑰𝑵𝑺 - PRACTICE QUESTIONS
-- Topics: LEFT JOIN, RIGHT JOIN, including unmatched records
-- ===========================================================

-- PRACTICE QUESTION 1
-- Show all staff members and their schedule information 
-- (including those with no schedule entries)
-- SELECT
--     s.staff_id,
--     s.staff_name,
--     s.role,
--     s.service,
--     COALESCE(SUM(ss.present), 0) AS total_present_weeks,
--     COUNT(ss.week) AS total_weeks_recorded
-- FROM staff s
-- LEFT JOIN staff_schedule ss 
--     ON s.staff_id = ss.staff_id
-- GROUP BY s.staff_id, s.staff_name, s.role, s.service
-- ORDER BY s.staff_id;


-- PRACTICE QUESTION 2
-- List all services from services_weekly and their corresponding
-- staff (include services with no staff)
-- SELECT
--     sw.service,
--     sw.week,
--     s.staff_id,
--     s.staff_name,
--     s.role
-- FROM services_weekly sw
-- LEFT JOIN staff s 
--     ON sw.service = s.service
-- ORDER BY sw.service, sw.week;


-- PRACTICE QUESTION 3
-- Display all patients and their service’s weekly statistics (if available)
-- SELECT
--     p.patient_id,
--     p.name AS patient_name,
--     p.service,
--     sw.week,
--     sw.patients_admitted,
--     sw.patients_refused,
--     sw.patient_satisfaction
-- FROM patients p
-- LEFT JOIN services_weekly sw 
--     ON p.service = sw.service
-- ORDER BY p.patient_id;


-- =====================================================
-- 						DAILY CHALLENGE
-- =====================================================
-- Staff utilisation report showing all staff & their present weeks.
SELECT
    s.staff_id,
    s.staff_name,
    s.role,
    s.service,
    COALESCE(SUM(ss.present), 0) AS weeks_present
FROM staff s
LEFT JOIN staff_schedule ss
    ON s.staff_id = ss.staff_id
GROUP BY s.staff_id, s.staff_name, s.role, s.service
ORDER BY weeks_present DESC, s.staff_name;
