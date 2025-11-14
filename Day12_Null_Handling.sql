-- =====================================================
-- DAY 12: NULL HANDLING - PRACTICE QUESTIONS
-- Topic: NULL handling, IS NULL, IS NOT NULL, COALESCE
-- =====================================================

-- PRACTICE QUESTION 1
-- Find all weeks in services_weekly where no special event occurred

-- SELECT *
-- FROM services_weekly
-- WHERE event IS NULL;


-- PRACTICE QUESTION 2
-- Count how many records have null or empty event values

-- SELECT
--     COUNT(*) AS total_rows,
--     COUNT(event) AS non_null_events,
--     COUNT(*) - COUNT(event) AS null_events,
--     SUM(CASE WHEN event = '' THEN 1 ELSE 0 END) AS empty_events,
--     SUM(CASE WHEN event IS NULL OR event = '' THEN 1 ELSE 0 END) AS null_or_empty_events
-- FROM services_weekly;


-- PRACTICE QUESTION 3
-- List all services that had at least one week with a special event

-- SELECT DISTINCT service
-- FROM services_weekly
-- WHERE event IS NOT NULL
--     AND event != ''
-- ORDER BY service;


-- =====================================================
-- DAILY CHALLENGE
-- =====================================================

-- Analyze the event impact by comparing weeks with events vs weeks without events.
-- Show: event status ('With Event' or 'No Event'), count of weeks, 
-- average patient satisfaction, and average staff morale.
-- Order by average patient satisfaction descending.

SELECT
    CASE
        WHEN event IS NOT NULL AND event != '' THEN 'With Event'
        ELSE 'No Event'
    END AS event_status,
    COUNT(*) AS week_count,
    ROUND(AVG(patient_satisfaction), 2) AS avg_patient_satisfaction,
    ROUND(AVG(staff_morale), 2) AS avg_staff_morale
FROM services_weekly
GROUP BY 
    CASE
        WHEN event IS NOT NULL AND event != '' THEN 'With Event'
        ELSE 'No Event'
    END
ORDER BY avg_patient_satisfaction DESC;
