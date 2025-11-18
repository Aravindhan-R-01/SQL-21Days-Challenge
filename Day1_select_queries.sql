-- Day 1: Introduction to SQL & SELECT Statement

-- 1. Retrieve all columns from the patients table
SELECT * FROM patients;

-- 2. Select only patient_id, name, and age
SELECT patient_id, name, age FROM patients;

-- 3. Display first 10 records from service_weekly
SELECT * FROM service_weekly LIMIT 10;

-- Daily Challenge: List all unique hospital services
SELECT DISTINCT service FROM patients;
