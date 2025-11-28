-- ============================================================================
-- 					   	   Capstone Project (28/11/25)👮‍♂️
-- 					 SQL Murder Mystery: “Who Killed the CEO?”
-- ============================================================================
-- TO VERIFY TABLES:

-- SELECT table_name
-- FROM information_schema.tables
-- WHERE table_schema = 'public'
-- ORDER BY table_name;



-- STEP 1 => Confirm evidence at CEO Office (crime scene & time)

-- SELECT * 
-- FROM evidence
-- WHERE room = 'CEO Office'
-- ORDER BY found_time;



-- STEP 2 => Who accessed the CEO Office around the incident (20:45 - 21:05)

-- SELECT k.log_id, k.employee_id, e.name, k.room, k.entry_time, k.exit_time
-- FROM keycard_logs k
-- JOIN employees e ON k.employee_id = e.employee_id
-- WHERE k.room = 'CEO Office'
--   AND k.entry_time BETWEEN '2025-10-15 20:45:00' AND '2025-10-15 21:05:00'
-- ORDER BY k.entry_time;



-- STEP 3 => Who claimed an alibi at ~20:50 (and check if keycard proves it)

-- SELECT a.alibi_id, a.employee_id, e.name, a.claimed_location, a.claim_time,
--        k.log_id AS matched_log, k.room AS actual_room, k.entry_time, k.exit_time
-- FROM alibis a
-- LEFT JOIN employees e ON a.employee_id = e.employee_id
-- LEFT JOIN keycard_logs k
--   ON a.employee_id = k.employee_id
--  AND k.entry_time BETWEEN a.claim_time - INTERVAL '15 minutes' AND a.claim_time + INTERVAL '15 minutes'
-- ORDER BY a.claim_time;



-- STEP 4 => Suspicious calls between 20:50 and 21:00

-- SELECT c.call_id, c.caller_id, caller.name AS caller_name,
--        c.receiver_id, receiver.name AS receiver_name,
--        c.call_time, c.duration_sec
-- FROM calls c
-- LEFT JOIN employees caller ON c.caller_id = caller.employee_id
-- LEFT JOIN employees receiver ON c.receiver_id = receiver.employee_id
-- WHERE c.call_time BETWEEN '2025-10-15 20:50:00' AND '2025-10-15 21:00:00'
-- ORDER BY c.call_time;



-- STEP 5 => Evidence + matches: what evidence found and when

-- SELECT * FROM evidence ORDER BY found_time;



-- STEP 6 => Combine suspicious entry + false alibi + call involvement (candidate set)

WITH entry AS (
  SELECT DISTINCT employee_id
  FROM keycard_logs
  WHERE room = 'CEO Office'
    AND entry_time BETWEEN '2025-10-15 20:45:00' AND '2025-10-15 21:05:00'
),
false_alibi AS (
  SELECT a.employee_id
  FROM alibis a
  LEFT JOIN keycard_logs k
    ON a.employee_id = k.employee_id
   AND k.entry_time BETWEEN a.claim_time - INTERVAL '15 minutes'
                        AND a.claim_time + INTERVAL '15 minutes'
  WHERE k.room IS DISTINCT FROM a.claimed_location
),
sus_calls AS (
  SELECT DISTINCT caller_id AS emp FROM calls WHERE call_time BETWEEN '2025-10-15 20:50' AND '2025-10-15 21:00'
  UNION
  SELECT DISTINCT receiver_id FROM calls WHERE call_time BETWEEN '2025-10-15 20:50' AND '2025-10-15 21:00'
)
SELECT e.employee_id, emp.name
FROM entry e
JOIN employees emp ON e.employee_id = emp.employee_id
WHERE e.employee_id IN (SELECT employee_id FROM false_alibi)
  AND e.employee_id IN (SELECT emp FROM sus_calls);
