-- Adds a derived end_date using LEAD() since source only has start_date
-- This is critical for SCD Type 2 and point-in-time salary lookups

SELECT
    RECORDID        AS record_id,
    CONSULTANTID    AS consultant_id,
    TITLEID         AS title_id,
    START_DATE      AS effective_start_date,
    -- Derive end date from the NEXT record's start date for same consultant
    LEAD(START_DATE) OVER (
        PARTITION BY CONSULTANTID 
        ORDER BY START_DATE
    )               AS effective_end_date,   -- NULL means current/active record
    EVENT_TYPE      AS event_type,
    SALARY          AS salary_annual,
    LAST_UPDATE     AS last_update
FROM {{ source('consulting', 'CONSULTANTTITLEHISTORY') }}
