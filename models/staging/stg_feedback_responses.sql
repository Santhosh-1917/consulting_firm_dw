SELECT
    RESPONSE_ID     AS response_id,
    QUESTION_ID     AS question_id,
    QUESTION_TEXT   AS question_text,
    RESPONSE_TYPE   AS response_type,
    RESPONSE_VALUE  AS response_value
FROM {{ source('consulting', 'FEEDBACK_RESPONSES') }}