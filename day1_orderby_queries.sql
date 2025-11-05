-- ============================================================
--                     DAY #3 - SQL PRACTICE
--     Topic: ORDER BY, ASC/DESC, Multi-column Sorting
-- ============================================================

-- View all data in services_weekly
SELECT * FROM services_weekly;

-- ------------------------------------------------------------
-- Practice 1:
-- List all patients sorted by age in descending order
-- ------------------------------------------------------------
SELECT * FROM patients ORDER BY age DESC;

-- ------------------------------------------------------------
-- Practice 2:
-- Show all services_weekly data sorted by:
-- week ascending (1 → 52) AND
-- patients_request descending (highest first)
-- ------------------------------------------------------------
SELECT * FROM services_weekly ORDER BY week ASC, patients_request DESC;

-- ------------------------------------------------------------
-- Practice 3:
-- Display staff members sorted alphabetically by their names
-- ------------------------------------------------------------
SELECT * FROM staff ORDER BY staff_name ASC;

-- ------------------------------------------------------------
-- Day #3 Challenge:
-- Retrieve the top 5 weeks with the highest patient refusals 
-- across all services.
-- Display: week, service, patients_refused, patients_request
-- Sort results by patients_refused in descending order
-- ------------------------------------------------------------
SELECT week, service, patients_refused, patients_request FROM services_weekly ORDER BY patients_refused DESC LIMIT 5;
