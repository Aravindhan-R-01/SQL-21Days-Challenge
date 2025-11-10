-- =============================================================
--                      DAY #7 Challenge + Practice
-- =============================================================

-- 														PRACTICE 1
-- Find services that have admitted more than 500 patients in total.
-- SELECT service, SUM(patients_admitted) AS total_admitted FROM services_weekly
-- GROUP BY service HAVING SUM(patients_admitted) > 500 ORDER BY total_admitted DESC;


-- 														PRACTICE 2
-- Show services where average patient satisfaction is below 75.
-- SELECT service, ROUND(AVG(patient_satisfaction), 2) AS avg_satisfaction
-- FROM services_weekly GROUP BY service ORDER BY avg_satisfaction ASC;


-- 														PRACTICE 3
-- List weeks where total staff presence across all services was less than 50.
-- SELECT week, SUM(present) AS total_staff FROM staff_schedule
-- GROUP BY week HAVING SUM(present) < 50 ORDER BY week;


-- 													  DAILY CHALLENGE
-- Identify services that refused more than 100 patients in total
-- and had an average satisfaction below 80.
SELECT 
  service, 
  SUM(patients_refused) AS total_refused, 
  ROUND(AVG(patient_satisfaction), 2) AS avg_satisfaction -- Corrected: Used 'patient_satisfaction'
FROM 
  services_weekly 
GROUP BY 
  service 
HAVING 
  SUM(patients_refused) > 100 AND AVG(patient_satisfaction) < 80 -- Corrected: Complete boolean condition
ORDER BY 
  total_refused DESC;
