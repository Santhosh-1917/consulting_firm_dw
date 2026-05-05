SELECT
    DELIVERABLEID       AS deliverable_id,
    PROJECTID           AS project_id,
    NAME                AS deliverable_name,
    CREATED_AT          AS created_at,
    PRICE               AS deliverable_price,
    PLANNED_START_DATE  AS planned_start_date,
    ACTUAL_START_DATE   AS actual_start_date,
    PLANNED_HOURS       AS planned_hours,
    DUE_DATE            AS due_date,
    STATUS              AS status,
    PROGRESS            AS progress_pct,
    SUBMISSION_DATE     AS submission_date,
    INVOICED_DATE       AS invoiced_date,
    LAST_UPDATE         AS last_update
FROM {{ source('consulting', 'DELIVERABLE') }}
