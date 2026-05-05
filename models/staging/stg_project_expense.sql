SELECT
    RECORDID        AS record_id,
    PROJECTID       AS project_id,
    DELIVERABLEID   AS deliverable_id,
    "DATE"          AS expense_date,
    AMOUNT          AS amount,
    DESCRIPTION     AS description,
    CATEGORY        AS category,
    IS_BILLABLE     AS is_billable
FROM {{ source('consulting', 'PROJECTEXPENSE') }}
