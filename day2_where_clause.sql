-- 📘 Day 2: Filtering Data with WHERE Clause
-- 21 Days SQL Challenge - Indian Data Club (IDC)
-- Date: 04-Nov-2025

-- Practice 1: Find all patients who are older than 60 years
SELECT * FROM patients WHERE age > 60;

-- Practice 2: Retrieve all staff members who work in the 'Emergency' service
SELECT * FROM staff WHERE service = 'Emergency';

-- Practice 3: List all weeks where more than 100 patients requested admission
SELECT * FROM services_weekly WHERE patients_request > 100;

-- 💡 Daily Challenge:
-- Find all patients admitted to 'Surgery' service with a satisfaction score below 70
SELECT patient_id, name, age, satisfaction FROM patients WHERE service = 'surgery' AND satisfaction < 70;
