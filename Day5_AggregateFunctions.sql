-- DAY #5: Aggregate Functions Practice and Challenge

-- Practice 1: Count total number of patients
SELECT COUNT(*) AS total_patients FROM patients;

-- Practice 2: Calculate average satisfaction score
SELECT AVG(satisfaction) AS avg_satisfaction FROM patients;

-- Practice 3: Find minimum and maximum age
SELECT MIN(age) AS min_age, MAX(age) AS max_age FROM patients;

-- Daily Challenge: 
-- Calculate total admitted, refused, and average satisfaction (rounded to 2 decimals)
SELECT 
    SUM(patients_admitted) AS total_admitted,
    SUM(patients_refused) AS total_refused,
    ROUND(AVG(avg_satisfaction), 2) AS avg_satisfaction
FROM services_weekly;
