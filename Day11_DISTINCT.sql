-- =====================================================
-- DAY 11: DISTINCT AND HANDLING DUPLICATES
-- Topic: DISTINCT, removing duplicates, unique values
-- =====================================================

-- PRACTICE QUESTION 1
-- List all unique services in the patients table

-- SELECT DISTINCT service 
-- FROM patients
-- ORDER BY service;


-- PRACTICE QUESTION 2
-- Find all unique staff roles in the hospital

-- SELECT DISTINCT role 
-- FROM staff
-- ORDER BY role;


-- PRACTICE QUESTION 3
-- Get distinct months from the services_weekly table

-- SELECT DISTINCT month 
-- FROM services_weekly
-- ORDER BY month;


-- =====================================================
-- DAILY CHALLENGE
-- =====================================================

-- Find all unique combinations of service and event type 
-- from the services_weekly table where events are not null or none,
-- along with the count of occurrences for each combination.
-- Order by count descending.
SELECT 
    service,
    event,
    COUNT(*) AS occurrence_count
FROM services_weekly
WHERE event IS NOT NULL 
    AND event != 'none'
GROUP BY service, event
ORDER BY occurrence_count DESC;
