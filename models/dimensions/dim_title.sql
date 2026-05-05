-- dim_title.sql
-- Simple title lookup dimension

SELECT
    title_id    AS title_key,
    title_id,
    title_name
FROM {{ ref('stg_title') }}
