SELECT
    PROJECTID   AS project_id,
    TITLEID     AS title_id,
    RATE        AS billing_rate
FROM {{ source('consulting', 'PROJECTBILLINGRATE') }}
