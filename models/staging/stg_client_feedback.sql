SELECT
    RESPONSEID              AS response_id,
    PROJECTID               AS project_id,
    CLIENTID                AS client_id,
    SURVEYDATE              AS survey_date,
    OVERALLSATISFACTION     AS overall_satisfaction
FROM {{ source('consulting', 'CLIENT_FEEDBACK') }}
