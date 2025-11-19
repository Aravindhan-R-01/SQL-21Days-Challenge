-- =====================================================
-- DAY 15: MULTIPLE JOINS - PRACTICE QUESTIONS
-- Topic: Joining more than two tables, complex relationships
-- =====================================================

-- PRACTICE QUESTION 1
-- Join patients, staff, and staff_schedule to show patient service and staff availability

-- SELECT
--     p.patient_id,
--     p.name AS patient_name,
--     p.service,
--     p.arrival_date,
--     s.staff_id,
--     s.staff_name,
--     s.role,
--     ss.week,
--     ss.present AS staff_present
-- FROM patients p
-- LEFT JOIN staff s ON p.service = s.service
-- LEFT JOIN staff_schedule ss ON s.staff_id = ss.staff_id
-- ORDER BY p.patient_id, s.staff_id, ss.week;


-- PRACTICE QUESTION 2
-- Combine services_weekly with staff and staff_schedule for comprehensive service analysis

-- SELECT
--     sw.service,
--     sw.week,
--     sw.patients_admitted,
--     sw.patients_refused,
--     sw.patient_satisfaction,
--     COUNT(DISTINCT s.staff_id) AS total_staff_assigned,
--     SUM(CASE WHEN ss.present = 1 THEN 1 ELSE 0 END) AS staff_present_count,
--     ROUND(AVG(CASE WHEN ss.present = 1 THEN 1.0 ELSE 0.0 END) * 100, 2) AS staff_attendance_rate
-- FROM services_weekly sw
-- LEFT JOIN staff s ON sw.service = s.service
-- LEFT JOIN staff_schedule ss 
--     ON s.staff_id = ss.staff_id
--     AND sw.week = ss.week
-- GROUP BY sw.service, sw.week, sw.patients_admitted, sw.patients_refused, sw.patient_satisfaction
-- ORDER BY sw.service, sw.week;


-- PRACTICE QUESTION 3
-- Create a multi-table report showing patient admissions with staff information

-- SELECT
--     p.patient_id,
--     p.name AS patient_name,
--     p.service,
--     p.arrival_date,
--     p.satisfaction,
--     COUNT(DISTINCT s.staff_id) AS total_assigned_staff,
--     STRING_AGG(DISTINCT s.role, ', ') AS staff_roles,
--     AVG(ss.present) AS avg_staff_presence
-- FROM patients p
-- LEFT JOIN staff s ON p.service = s.service
-- LEFT JOIN staff_schedule ss ON s.staff_id = ss.staff_id
-- GROUP BY p.patient_id, p.name, p.service, p.arrival_date, p.satisfaction
-- ORDER BY p.arrival_date DESC;


-- =====================================================
-- DAILY CHALLENGE
-- =====================================================

-- Create a comprehensive service analysis report for week 20 showing:
-- service name, total patients admitted that week, total patients refused,
-- average patient satisfaction, count of staff assigned to service,
-- and count of staff present that week.
-- Order by patients admitted descending.

SELECT
    sw.service,
    sw.patients_admitted,
    sw.patients_refused,
    ROUND(sw.patient_satisfaction, 2) AS avg_patient_satisfaction,
    COUNT(DISTINCT s.staff_id) AS staff_assigned_count,
    SUM(CASE WHEN ss.present = 1 THEN 1 ELSE 0 END) AS staff_present_count
FROM services_weekly sw
LEFT JOIN staff s ON sw.service = s.service
LEFT JOIN staff_schedule ss 
    ON s.staff_id = ss.staff_id
    AND ss.week = 20
WHERE sw.week = 20
GROUP BY sw.service, sw.patients_admitted, sw.patients_refused, sw.patient_satisfaction
ORDER BY sw.patients_admitted DESC;
