SELECT
    YEARMONTH               AS year_month,
    BUSINESS_UNIT_ID        AS business_unit_id,
    NON_PROJ_LABOR_COSTS    AS non_project_labor_costs,
    OTHER_EXPENSE_COSTS     AS other_expense_costs,
    TOTAL_INDIRECT_COSTS    AS total_indirect_costs
FROM {{ source('consulting', 'INDIRECT_COSTS') }}
