SELECT
    PROJECTID       AS project_id,
    CONSULTANTID    AS consultant_id,
    ROLE            AS role,
    START_DATE      AS start_date,
    END_DATE        AS end_date
FROM {{ source('consulting', 'PROJECTTEAM') }}
