-- ============================================================================
-- DAY 21: Common Table Expressions (CTEs) - PRACTICE QUESTIONS
-- Topic: WITH clause, CTEs, recursive CTEs (if applicable), query organization
-- ============================================================================
-- PRACTICE QUESTION 1
-- CTE for service statistics
-- WITH service_stats AS (
--     SELECT
--         service,
--         SUM(patients_admitted) AS total_admitted,
--         SUM(patients_refused) AS total_refused,
--         ROUND(AVG(patient_satisfaction),2) AS avg_satisfaction
--     FROM services_weekly
--     GROUP BY service
-- )
-- SELECT *
-- FROM service_stats
-- ORDER BY total_admitted DESC;


-- PRACTICE QUESTION 2
-- Multiple CTEs (breaking down complex logic)
-- WITH
-- patient_stats AS (
--     SELECT
--         service,
--         COUNT(*) AS total_patients,
--         ROUND(AVG(age),2) AS avg_age,
--         ROUND(AVG(satisfaction),2) AS avg_satisfaction
--     FROM patients
--     GROUP BY service
-- ),
-- weekly_stats AS (
--     SELECT
--         service,
--         SUM(patients_admitted) AS total_admitted,
--         SUM(patients_refused) AS total_refused
--     FROM services_weekly
--     GROUP BY service
-- ),
-- staff_stats AS (
--     SELECT
--         service,
--         COUNT(*) AS total_staff
--     FROM staff
--     GROUP BY service
-- )
-- SELECT
--     ps.service,
--     ps.total_patients,
--     ps.avg_age,
--     ps.avg_satisfaction,
--     ss.total_staff,
--     ws.total_admitted,
--     ws.total_refused
-- FROM patient_stats ps
-- LEFT JOIN staff_stats ss ON ps.service = ss.service
-- LEFT JOIN weekly_stats ws ON ps.service = ws.service
-- ORDER BY ps.service;


-- PRACTICE QUESTION 3
-- Staff utilization CTE joined with patient data
-- WITH staff_util AS (
--     SELECT
--         s.service,
--         s.staff_id,
--         s.staff_name,
--         ROUND(AVG(COALESCE(ss.present, 0)),2) AS avg_weeks_present
--     FROM staff s
--     LEFT JOIN staff_schedule ss ON s.staff_id = ss.staff_id
--     GROUP BY s.service, s.staff_id, s.staff_name
-- )
-- SELECT
--     p.patient_id,
--     p.name AS patient_name,
--     p.service,
--     su.staff_id,
--     su.staff_name,
--     su.avg_weeks_present
-- FROM patients p
-- LEFT JOIN staff_util su
--     ON p.service = su.service
-- ORDER BY p.service, p.name;


-- ========================================================================
-- 					          DAILY CHALLENGE
-- ========================================================================
-- Create a comprehensive hospital performance dashboard using CTEs. Calculate: 
-- 1) Service-level metrics (total admissions, refusals, avg satisfaction), 
-- 2) Staff metrics per service (total staff, avg weeks present), 
-- 3) Patient demographics per service (avg age, count). 
-- Then combine all three CTEs to create a final report showing service name, 
-- all calculated metrics, and an overall performance score (weighted average of 
-- admission rate and satisfaction). Order by performance score descending.
WITH
-- 1. Service-level metrics
service_metrics AS (
    SELECT
        service,
        SUM(patients_admitted) AS total_admitted,
        SUM(patients_refused) AS total_refused,
        ROUND(AVG(patient_satisfaction),2) AS avg_satisfaction,
        CASE 
            WHEN SUM(patients_admitted) + SUM(patients_refused) = 0 THEN 0
            ELSE ROUND(
                100.0 * SUM(patients_admitted)
                / (SUM(patients_admitted) + SUM(patients_refused)), 2
            )
        END AS admission_rate
    FROM services_weekly
    GROUP BY service
),
-- 2. Staff metrics
staff_metrics AS (
    SELECT
        s.service,
        COUNT(s.staff_id) AS total_staff,
        ROUND(AVG(COALESCE(ss.present, 0)),2) AS avg_weeks_present
    FROM staff s
    LEFT JOIN staff_schedule ss ON s.staff_id = ss.staff_id
    GROUP BY s.service
),
-- 3. Patient demographics
patient_metrics AS (
    SELECT
        service,
        COUNT(*) AS total_patients,
        ROUND(AVG(age),2) AS avg_age
    FROM patients
    GROUP BY service
)
-- Final combined dashboard
SELECT
    sm.service,
    pm.total_patients,
    pm.avg_age,
    sm.total_admitted,
    sm.total_refused,
    sm.avg_satisfaction,
    st.total_staff,
    st.avg_weeks_present,
    -- Weighted performance score (60% satisfaction + 40% admission rate)
    ROUND(
        (0.6 * sm.avg_satisfaction) +
        (0.4 * sm.admission_rate), 2
    ) AS performance_score
FROM service_metrics sm
LEFT JOIN staff_metrics st ON sm.service = st.service
LEFT JOIN patient_metrics pm ON sm.service = pm.service
ORDER BY performance_score DESC;
