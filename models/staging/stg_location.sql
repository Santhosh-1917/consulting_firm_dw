SELECT
    LOCATIONID  AS location_id,
    STATE       AS state,
    CITY        AS city
FROM {{ source('consulting', 'LOCATION') }}
