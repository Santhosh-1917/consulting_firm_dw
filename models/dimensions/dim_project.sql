-- dim_project.sql
-- Conformed project dimension shared across all datamarts

SELECT
    p.project_id            AS project_key,
    p.project_id,
    p.project_name,
    p.project_type,
    p.status,
    p.progress_pct,
    p.contract_price,
    p.estimated_budget,
    p.planned_hours,
    p.planned_start_date,
    p.planned_end_date,
    p.actual_start_date,
    p.actual_end_date,
    p.client_id,
    p.business_unit_id,
    p.created_at,
    p.last_update
FROM {{ ref('stg_project') }} p
