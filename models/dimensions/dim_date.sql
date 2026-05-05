-- dim_date.sql
-- Generated date spine — no source table, creates a row for every date
-- Covers the full range of data in the source system

WITH date_spine AS (
    SELECT
        DATEADD(DAY, seq4(), '2023-01-01'::DATE) AS calendar_date
    FROM TABLE(GENERATOR(ROWCOUNT => 1461))  -- ~4 years: 2023-2026
)

SELECT
    TO_NUMBER(TO_CHAR(calendar_date, 'YYYYMMDD'))   AS date_key,
    calendar_date,
    DATE_TRUNC('MONTH', calendar_date)              AS first_day_of_month,
    EXTRACT(DAY FROM calendar_date)                 AS day_of_month,
    EXTRACT(MONTH FROM calendar_date)               AS month_number,
    TO_CHAR(calendar_date, 'Mon')                   AS month_short_name,
    TO_CHAR(calendar_date, 'Month')                 AS month_name,
    EXTRACT(QUARTER FROM calendar_date)             AS quarter_number,
    'Q' || EXTRACT(QUARTER FROM calendar_date)      AS quarter_name,
    EXTRACT(YEAR FROM calendar_date)                AS year_number,
    TO_CHAR(calendar_date, 'YYYY-MM')               AS year_month,
    EXTRACT(DAYOFWEEK FROM calendar_date)           AS day_of_week,
    TO_CHAR(calendar_date, 'Dy')                    AS day_of_week_name,
    CASE 
        WHEN EXTRACT(DAYOFWEEK FROM calendar_date) IN (0, 6) THEN TRUE 
        ELSE FALSE 
    END                                             AS is_weekend,
    CASE 
        WHEN calendar_date = LAST_DAY(calendar_date) THEN TRUE 
        ELSE FALSE 
    END                                             AS is_month_end,
    -- Fiscal year (assuming fiscal year = calendar year; adjust if needed)
    EXTRACT(YEAR FROM calendar_date)                AS fiscal_year,
    EXTRACT(MONTH FROM calendar_date)               AS fiscal_month
FROM date_spine
WHERE calendar_date <= '2026-12-31'
