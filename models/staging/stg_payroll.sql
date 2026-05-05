SELECT
    RECORDID        AS record_id,
    CONSULTANTID    AS consultant_id,
    AMOUNT          AS payment_amount,
    PAYMENT_DATE    AS payment_date
FROM {{ source('consulting', 'PAYROLL') }}
