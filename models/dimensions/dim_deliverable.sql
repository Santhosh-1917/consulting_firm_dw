-- dim_deliverable.sql
-- Conformed deliverable dimension

SELECT
    d.deliverable_id        AS deliverable_key,
    d.deliverable_id,
    d.project_id,
    d.deliverable_name,
    d.deliverable_price,
    d.planned_hours,
    d.planned_start_date,
    d.due_date,
    d.actual_start_date,
    d.status,
    d.progress_pct,
    d.submission_date,
    d.invoiced_date,
    -- Is this deliverable accepted/complete?
    CASE 
        WHEN d.status = 'Completed' THEN TRUE 
        ELSE FALSE 
    END                     AS is_completed,
    CASE 
        WHEN d.invoiced_date IS NOT NULL THEN TRUE 
        ELSE FALSE 
    END                     AS is_invoiced,
    d.created_at,
    d.last_update
FROM {{ ref('stg_deliverable') }} d
