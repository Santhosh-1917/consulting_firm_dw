-- dim_consultant.sql
-- SCD Type 2 consultant dimension
-- Each row = one version of a consultant (a specific title + salary period)
-- effective_end_date IS NULL means this is the current/active record

SELECT
    -- Surrogate key: unique per consultant per version
    cth.record_id                   AS consultant_key,
    c.consultant_id,
    c.first_name,
    c.last_name,
    c.first_name || ' ' || c.last_name  AS full_name,
    c.email,
    c.contact_phone,
    c.hire_year,
    c.business_unit_id              AS home_business_unit_id,
    bu.business_unit_name           AS home_business_unit_name,
    cth.title_id,
    t.title_name,
    cth.salary_annual,
    -- Derived hourly cost rate (2080 standard work hours per year)
    ROUND(cth.salary_annual / 2080, 2)  AS hourly_cost_rate,
    cth.event_type,
    cth.effective_start_date,
    cth.effective_end_date,
    -- Is this the current version?
    CASE 
        WHEN cth.effective_end_date IS NULL THEN TRUE 
        ELSE FALSE 
    END                             AS is_current
FROM {{ ref('stg_consultant_title_history') }} cth
JOIN {{ ref('stg_consultant') }} c
    ON cth.consultant_id = c.consultant_id
JOIN {{ ref('stg_title') }} t
    ON cth.title_id = t.title_id
LEFT JOIN {{ ref('stg_business_unit') }} bu
    ON c.business_unit_id = bu.business_unit_id
