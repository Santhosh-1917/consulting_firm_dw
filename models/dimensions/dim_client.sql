-- dim_client.sql
-- Conformed client dimension — joins client with location for state/city

SELECT
    c.client_id             AS client_key,
    c.client_id,
    c.client_name,
    c.phone_number,
    c.email,
    l.state,
    l.city,
    c.last_update
FROM {{ ref('stg_client') }} c
LEFT JOIN {{ ref('stg_location') }} l
    ON c.location_id = l.location_id
