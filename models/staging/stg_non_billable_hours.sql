SELECT
    CONSULTANTID        AS consultant_id,
    "DATE"              AS record_date,
    YEARMONTH           AS year_month,
    BILLABLE_HOURS      AS billable_hours,
    TABLE_NONBILLABLEHOURS    AS non_billable_hours,
    FIRSTNAME           AS first_name,      -- denormalized, use for validation only
    LASTNAME            AS last_name        -- denormalized, use for validation only
FROM {{ source('consulting', 'NON_BILLABLE_HOURS') }}
