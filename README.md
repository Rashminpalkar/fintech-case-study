# QuickPay Fintech Case Study

## Project Overview

This project is a complete fintech analytics case study built using Excel, SQL, Python, Pandas, and Looker Studio.

The objective of this assignment was to simulate a real-world fintech data workflow involving:

- transaction data cleaning and standardization
- SQL-based business analysis
- reconciliation workflow between payment systems
- JSON normalization
- dashboard visualization for business monitoring

The project follows an end-to-end analytics pipeline commonly used in fintech and payment operations.

---

# Project Structure

```text
QuickPay-Fintech-Case-Study/
├── README.md
├── 01_data/
│   ├── raw/
│   │   ├── transactions_raw.csv
│   │   ├── merchant_master.csv
│   │   ├── users.csv
│   │   ├── ledger.csv
│   │   ├── gateway.csv
│   │   ├── exchange_rates.csv
│   │   └── api_response_sample.json
│   └── processed/
│       ├── cleaned_transactions.csv
│       ├── merchant_risk_summary.csv
│       ├── missing_in_gateway.csv
│       ├── missing_in_ledger.csv
│       ├── amount_mismatches.csv
│       ├── status_mismatches.csv
│       ├── reconciliation_report.csv
│       ├── api_normalized.csv
│       ├── daily_summary.csv
│       ├── payment_method_breakdown.csv
│       ├── region_breakdown.csv
│       └── merchant_performance_summary.csv
├── 02_spreadsheet/
│   ├── spreadsheet_workbook.xlsx
│   └── spreadsheet_answers.md
├── 03_sql/
│   ├── analysis_queries.sql
│   └── sql_answers.md
├── 04_python/
│   ├── fintech_pipeline.ipynb
│   └── summary_metrics.json
└── 05_visualization/
    └── dashboard_link.txt
```

---

# Phase 1 — Excel Data Cleaning & Standardization

## Tasks Performed

- Cleaned transaction dataset
- Standardized merchant names
- Standardized transaction status values
- Standardized risk score fields
- Standardized gateway region values
- Converted raw amounts into USD using exchange rates
- Enriched data using merchant master dataset
- Created business flags:
  - high_value_flag
  - high_risk_flag

## Key Outputs

- cleaned_transactions_export.csv
- merchant_risk_summary.csv
- merchant_summary.csv
- spreadsheet_answers.md

---

# Phase 2 — SQL Business Analysis

## SQL Objectives

Performed SQL analysis on the cleaned transaction dataset to generate business insights.

## Analysis Performed

- Transaction status analysis
- Captured GMV analysis
- Merchant-wise GMV ranking
- Daily transaction trend analysis
- Chargeback ratio analysis
- Region-based risk analysis
- Suspicious user activity detection
- Merchant chargeback impact analysis

## Key Outputs

 - analysis_queries.sql
 - sql_answers.md

---

# Phase 3 — Python Reconciliation Workflow

## Objective

Built a reconciliation workflow between:

- ledger.csv
- gateway.csv

using Python and Pandas.

## Validation Checks

- Duplicate checks
- Null value checks
- Missing records detection
- Amount mismatch validation
- Status mismatch validation

## Outputs Generated

- missing_in_gateway.csv
- missing_in_ledger.csv
- amount_mismatches.csv
- status_mismatches.csv
- reconciliation_report.csv


## Summary Metrics

Generated summary_metrics.json containing reconciliation KPIs.

---

# Phase 4 — JSON Normalization

## Objective

Normalized nested settlement API response data.

## Tasks Performed

- Read nested JSON structure
- Flattened settlement records into tabular format
- Cleaned column names
- Converted date/time fields
- Exported normalized dataset

## Output

api_normalized.csv

---

# Phase 5 — Dashboard Visualization

## Tool Used

- Looker Studio

## Dashboard Features

### KPI Cards

- Total GMV
- Confirmed GMV
- Amount at Risk
- Success Rate

### Trend Analysis

- Daily GMV trend over time

### Breakdown Analysis

- GMV by payment method
- GMV breakdown by merchant

### Detailed View

- Transaction performance table

### Interactive Filters

- Date filter
- Gateway region filter

---

# Technologies Used

| Technology | Purpose |
|---|---|
| Excel | Data cleaning and standardization |
| SQL | Business analysis |
| Python | Reconciliation workflow |
| Pandas | Data processing |
| JSON | API normalization |
| Looker Studio | Dashboard visualization |
| Git & GitHub | Version control |

---

# Key Learnings

Through this project, I gained hands-on experience in:

- fintech transaction workflows
- reconciliation logic
- SQL-based business analysis
- data cleaning and transformation
- JSON normalization
- dashboard development
- analytics reporting
- GitHub project management

---

# Author

Rashmin Palkar