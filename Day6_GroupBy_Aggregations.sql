-- Practice 1:
-- Count the number of patients by each service
SELECT service, COUNT(*) AS total_patients
FROM patients
GROUP BY service;

-- Practice 2:
-- Calculate the average age of patients grouped by service
SELECT service, ROUND(AVG(age), 2) AS avg_age
FROM patients
GROUP BY service;

-- Practice 3:
-- Find the total number of staff members per role
SELECT role, COUNT(*) AS total_staff
FROM staff
GROUP BY role;

-- =============================================================
--                      DAY #6 Challenge
-- =============================================================

-- For each hospital service, calculate:
-- 1️⃣ Total patients admitted
-- 2️⃣ Total patients refused
-- 3️⃣ Admission rate (% of requests admitted)
-- Then order by admission rate (descending)
SELECT 
    service,
    SUM(patients_admitted) AS total_admitted,
    SUM(patients_refused) AS total_refused,
    ROUND((SUM(patients_admitted)::numeric / 
          (SUM(patients_admitted) + SUM(patients_refused))) * 100, 2) AS admission_rate
FROM services_weekly
GROUP BY service
ORDER BY admission_rate DESC;
