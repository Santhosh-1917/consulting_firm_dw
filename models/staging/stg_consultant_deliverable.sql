-- This is the daily work log — consultants logging hours per deliverable per day
-- Downstream models will aggregate this to monthly grain

SELECT
    RECORDID        AS record_id,
    CONSULTANTID    AS consultant_id,
    DELIVERABLEID   AS deliverable_id,
    "DATE"          AS work_date,          -- quoted because DATE is a reserved word
    HOURS           AS hours_worked,
    LAST_UPDATE     AS last_update
FROM {{ source('consulting', 'CONSULTANTDELIVERABLE') }}
