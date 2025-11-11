-- =============================================================
--                      DAY #8 Challenge + Practice
-- =============================================================

-- 														PRACTICE 1
-- 🧠 1️⃣ Convert all patient names to uppercase
-- SELECT 
--     patient_id,
--     UPPER(name) AS name_upper
-- FROM patients;


-- 														PRACTICE 2
-- 🧠 2️⃣ Find the length of each staff member's name
-- SELECT 
--     staff_id,
--     staff_name,
--     LENGTH(staff_name) AS name_length
-- FROM staff;

-- 														PRACTICE 3
-- 🧠 3️⃣ Concatenate staff_id and staff_name with a hyphen separator
-- SELECT 
--     staff_id,
--     staff_name,
--     CONCAT(staff_id, ' - ', staff_name) AS staff_info
-- FROM staff;

-- 													  DAILY CHALLENGE
-- Create a patient summary that shows patient_id, full name in uppercase, service in lowercase, age category 
-- (if age >= 65 then 'Senior', if age >= 18 then 'Adult', else 'Minor'), and name length. Only 
-- show patients whose name length is greater than 10 characters.
SELECT 
    patient_id,
    UPPER(name) AS full_name,
    LOWER(service) AS service,
    CASE 
        WHEN age >= 65 THEN 'Senior'
        WHEN age >= 18 THEN 'Adult'
        ELSE 'Minor'
    END AS age_category,
    LENGTH(name) AS name_length
FROM patients
WHERE LENGTH(name) > 10;
