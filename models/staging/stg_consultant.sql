SELECT
    CONSULTANTID    AS consultant_id,
    BUSINESSUNITID  AS business_unit_id,
    FIRST_NAME      AS first_name,
    LAST_NAME       AS last_name,
    EMAIL           AS email,
    CONTACT         AS contact_phone,
    HIRE_YEAR       AS hire_year,
    LAST_UPDATE     AS last_update
FROM {{ source('consulting', 'CONSULTANT') }}
