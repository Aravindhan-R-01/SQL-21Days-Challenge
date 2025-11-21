-- =====================================================================
-- DAY 16: Subqueries (WHERE clause) - PRACTICE QUESTIONS
-- Topic: Subqueries in WHERE, nested queries, filtering with subqueries
-- =====================================================================

-- PRACTICE QUESTION 1
-- Find patients who are in services with above-average staff count
-- SELECT p.patient_id, p.name, p.service
-- FROM patients p
-- WHERE p.service IN (
--     SELECT service
--     FROM staff
--     GROUP BY service
--     HAVING COUNT(staff_id) > (SELECT AVG(staff_count) FROM 
-- 	(SELECT service, COUNT(*) AS  staff_count FROM staff GROUP BY service)sub)
-- );


-- PRACTICE QUESTION 2
-- List staff who work in services that had any week with satisfaction < 70
-- SELECT staff_id, staff_name, role, service
-- FROM staff
-- WHERE service IN (
--     SELECT DISTINCT service
--     FROM services_weekly
--     WHERE patient_satisfaction < 70
-- );


-- PRACTICE QUESTION 3
-- Create a multi-table report showing patient admissions with staff information
-- SELECT patient_id, name, service
-- FROM patients
-- WHERE service IN (
--     SELECT service
--     FROM services_weekly
--     GROUP BY service
--     HAVING SUM(patients_admitted) > 1000
-- );


-- =====================================================
-- 					          DAILY CHALLENGE
-- =====================================================
-- Find all patients admitted to services that had at least one week with refusals 
-- AND the average satisfaction was below the hospital-wide satisfaction average.
SELECT p.patient_id, p.name, p.service, p.satisfaction
FROM patients p
WHERE p.service IN (
    SELECT service
    FROM services_weekly
    GROUP BY service
    HAVING 
        SUM(patients_refused) > 0
        AND AVG(patient_satisfaction) < (
            SELECT AVG(patient_satisfaction)
            FROM services_weekly
        )
)
ORDER BY p.satisfaction ASC;
