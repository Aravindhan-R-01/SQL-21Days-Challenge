-- =============================================================
--                      DAY #9 Challenge + Practice
-- =============================================================

-- 														PRACTICE 1
-- Extract the year from all patient arrival dates
-- SELECT patient_id, name, arrival_date,
-- EXTRACT(YEAR FROM arrival_date) AS arrival_year FROM patients;

-- 														PRACTICE 2
-- Calculate the length of stay for each patient (departure_date - arrival_date)
-- SELECT patient_id, name, arrival_date, departure_date,
-- (departure_date - arrival_date) AS length_of_stay_days FROM patients;

-- 														PRACTICE 3
-- Find all patients who arrived in a specific month 
-- SELECT patient_id, name, arrival_date, 
-- EXTRACT(MONTH FROM arrival_date) AS arrival_month FROM patients
-- WHERE EXTRACT(MONTH FROM arrival_date) = 1;

-- 													  DAILY CHALLENGE
-- Calculate the average length of stay (in days) for each service, showing only services where the average 
-- stay is more than 7 days. Also show the count of patients and order by average stay descending.
SELECT service,
    COUNT(patient_id) AS patient_count,
    ROUND(AVG(departure_date - arrival_date), 2) AS avg_length_of_stay_days
FROM patients
WHERE departure_date IS NOT NULL
GROUP BY service
HAVING AVG(departure_date - arrival_date) > 7
ORDER BY avg_length_of_stay_days DESC;
