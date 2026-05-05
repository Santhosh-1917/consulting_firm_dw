# Consulting Firm Data Warehouse — dbt Project
## ISE-558 Deliverable 3 | Group 11

## Source Database
- **Initial:** `FCQRYRK_JF44780_ISE558_SHARE.CONSULTING`
- **Updated:** `FCQRYRK_JF44780_ISE558_SHARE_UPDATED.CONSULTING_UPDATED`
- **17 source tables**, all referenced in `models/staging/sources.yml`

## Key Data Quality Notes
- `PROJECT.TYPE` has 3 values: "Fixed", "Fixed Price", "Time and Material"
  - **"Fixed" and "Fixed Price" are standardized to "Fixed Price" in stg_project**
- `PROGRESS` columns are 0–100 scale (not 0.0–1.0)
- `CONSULTANTDELIVERABLE` is **daily grain** — aggregate to monthly for fact tables
- `CONSULTANTTITLEHISTORY` has no end_date — **derived via LEAD() in stg_consultant_title_history**
- Event types are only: Hire, Layoff (title/salary changes = new row with different title/salary)
- `DATE` is a reserved word in Snowflake — use `"DATE"` in queries

## Project Structure
```
models/
├── staging/            ← 17 staging models (1 per source table)
│   ├── sources.yml     ← Points at both Snowflake shares
│   ├── schema.yml      ← Tests for staging models
│   └── stg_*.sql
├── dimensions/         ← 7 shared dimensions
│   ├── schema.yml
│   ├── dim_date.sql
│   ├── dim_project.sql
│   ├── dim_client.sql
│   ├── dim_business_unit.sql
│   ├── dim_consultant.sql    ← SCD Type 2
│   ├── dim_deliverable.sql
│   └── dim_title.sql
└── marts/              ← Fact models (one folder per datamart)
    ├── project_delivery/     ← Person 2 builds here
    ├── human_resources/      ← Person 3 builds here
    └── financial/            ← Person 4 builds here
```

## How to Use (For Teammates)

### 1. Setup
- Install dbt: `pip install dbt-snowflake`
- Copy `profiles.yml` to `~/.dbt/profiles.yml`
- Update with your Snowflake credentials
- Set output database to your personal DB (e.g., `USER$YOURNAME`)

### 2. Test Connection
```bash
cd consulting_firm_dw
dbt debug
```

### 3. Run Staging + Dimensions
```bash
dbt run --select staging dimensions
```

### 4. Build Your Fact Model
Add your fact SQL file in the appropriate `marts/` subfolder, then:
```bash
dbt run --select marts.project_delivery   # Person 2
dbt run --select marts.human_resources    # Person 3
dbt run --select marts.financial          # Person 4
```

### 5. Run Tests
```bash
dbt test
```

## Conformed Dimensions (Shared Across All Datamarts)

| Dimension | Key | Source Tables | Notes |
|-----------|-----|---------------|-------|
| dim_date | date_key (YYYYMMDD) | Generated | 2023–2026 date spine |
| dim_project | project_id | PROJECT | Type standardized |
| dim_client | client_id | CLIENT + LOCATION | Includes state/city |
| dim_business_unit | business_unit_id | BUSINESSUNIT | 4 units |
| dim_consultant | record_id from history | CONSULTANT + CONSULTANTTITLEHISTORY + TITLE | SCD Type 2 |
| dim_deliverable | deliverable_id | DELIVERABLE | Includes price, status |
| dim_title | title_id | TITLE | T1–T6 lookup |

## Revenue Logic (Critical for Financial Datamart)
- **Fixed Price:** Revenue = `DELIVERABLE.PRICE` when deliverable status = 'Completed'
- **Time & Material:** Revenue = `CONSULTANTDELIVERABLE.HOURS × PROJECTBILLINGRATE.RATE` + billable expenses

## Payroll Cost Logic
- From title history: `salary_annual / 2080 * hours_worked`
- Or from PAYROLL table: actual payment amounts (use for validation)
