-- =====================================================================
-- DAY 17: Subqueries (SELECT and FROM clause) - PRACTICE QUESTIONS
-- Topic: Subqueries in SELECT, derived tables, inline views
-- =====================================================================
-- PRACTICE QUESTION 1
-- Show each patient with their service's average satisfaction as an additional column.
-- SELECT 
--     p.patient_id,
--     p.name,
--     p.service,
--     p.satisfaction,
--     (
--         SELECT ROUND(AVG(patient_satisfaction), 2)
--         FROM services_weekly sw
--         WHERE sw.service = p.service
--     ) AS service_avg_satisfaction
-- FROM patients p
-- ORDER BY p.service, p.name;


-- PRACTICE QUESTION 2
-- Create a derived table of service statistics and query from it.
-- SELECT *
-- FROM (
--     SELECT 
--         service,
--         SUM(patients_admitted) AS total_admitted,
--         SUM(patients_refused) AS total_refused,
--         ROUND(AVG(patient_satisfaction), 2) AS avg_satisfaction
--     FROM services_weekly
--     GROUP BY service
-- ) AS service_summary
-- ORDER BY avg_satisfaction DESC;



-- PRACTICE QUESTION 3
-- Display staff with their service's total patient count as a calculated field.
--  SELECT 
--     s.staff_id,
--     s.staff_name,
--     s.role,
--     s.service,
--     (
--         SELECT COUNT(*) 
--         FROM patients p 
--         WHERE p.service = s.service
--     ) AS total_patients_in_service
-- FROM staff s
-- ORDER BY total_patients_in_service DESC, s.staff_name;



-- ========================================================================
-- 					          DAILY CHALLENGE
-- ========================================================================
-- Create a report showing each service with: service name, total patients admitted, 
-- the difference between their total admissions and the average admissions across all services, 
-- and a rank indicator ('Above Average', 'Average', 'Below Average'). Order by total patients admitted descending.
SELECT 
    service,
    total_admitted,
    ROUND((total_admitted - avg_all_services),2) AS admission_difference,
    CASE
        WHEN total_admitted > avg_all_services THEN 'Above Average'
        WHEN total_admitted = avg_all_services THEN 'Average'
        ELSE 'Below Average'
    END AS performance_status
FROM (
    SELECT
        service,
        SUM(patients_admitted) AS total_admitted,
        (
            SELECT AVG(total)
            FROM (
                SELECT SUM(patients_admitted) AS total
                FROM services_weekly
                GROUP BY service
            ) AS temp
        ) AS avg_all_services
    FROM services_weekly
    GROUP BY service
) AS final_report
ORDER BY total_admitted DESC;
