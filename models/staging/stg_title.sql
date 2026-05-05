SELECT
    TITLEID     AS title_id,
    TITLE_NAME  AS title_name
FROM {{ source('consulting', 'TITLE') }}
