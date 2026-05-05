-- dim_business_unit.sql
-- Conformed business unit dimension

SELECT
    business_unit_id    AS business_unit_key,
    business_unit_id,
    business_unit_name
FROM {{ ref('stg_business_unit') }}
