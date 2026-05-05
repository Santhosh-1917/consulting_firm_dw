SELECT
    CLIENTID        AS client_id,
    CLIENT_NAME     AS client_name,
    LOCATIONID      AS location_id,
    PHONE_NUMBER    AS phone_number,
    EMAIL           AS email,
    LAST_UPDATE     AS last_update
FROM {{ source('consulting', 'CLIENT') }}
