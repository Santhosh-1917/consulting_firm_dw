-- stg_project.sql
-- Cleans and standardizes the PROJECT source table
-- KEY FIX: Standardizes 'Fixed' and 'Fixed Price' → 'Fixed Price'

SELECT
    PROJECTID                   AS project_id,
    CREATED_AT                  AS created_at,
    CLIENTID                    AS client_id,
    UNITID                      AS business_unit_id,
    NAME                        AS project_name,
    -- Standardize project type: 'Fixed' and 'Fixed Price' both → 'Fixed Price'
    CASE 
        WHEN TYPE IN ('Fixed', 'Fixed Price') THEN 'Fixed Price'
        ELSE TYPE
    END                         AS project_type,
    PRICE                       AS contract_price,
    ESTIMATED_BUDGET            AS estimated_budget,
    PLANNED_HOURS               AS planned_hours,
    PLANNED_START_DATE          AS planned_start_date,
    PLANNED_END_DATE            AS planned_end_date,
    STATUS                      AS status,
    ACTUAL_START_DATE           AS actual_start_date,
    ACTUAL_END_DATE             AS actual_end_date,
    PROGRESS                    AS progress_pct,
    LAST_UPDATE                 AS last_update
FROM {{ source('consulting', 'PROJECT') }}
