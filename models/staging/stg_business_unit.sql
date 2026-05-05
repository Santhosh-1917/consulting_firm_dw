SELECT
    BUSINESSUNITID      AS business_unit_id,
    BUSINESS_UNIT_NAME  AS business_unit_name
FROM {{ source('consulting', 'BUSINESSUNIT') }}
