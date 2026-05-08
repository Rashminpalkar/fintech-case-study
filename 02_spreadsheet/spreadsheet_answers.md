# Spreadsheet Answers

## Cleaning Steps

These were the cleaning operations that I performed on the transaction_raw dataset :

### Merchant Name Cleaning
- Removed leading and trailing spaces from merchant names using `TRIM()`

### Status Cleaning
- Removed unnecessary spaces from transaction status values using `TRIM()`

### Gateway Region Cleaning
- Removed extra spaces from gateway region values using `TRIM()`


## Standardization Rules

I applied the following standardization rules to ensure consistency across the dataset:

### Transaction Dates
- Converted transaction dates into a consistent short date format

### Merchant Names
- Standardized merchant names into consistent proper-case format using `PROPER()`

### Status Values
- Standardized transaction status values into consistent capitalization format using `PROPER()`

### Risk Scores
- Standardized mixed-format risk score values into numeric-only format
- Converted values such as:
  - `score:64`
  - `risk-68`
  - `44`
into a consistent numeric representation
- Used a combination of `VALUE()`, `RIGHT()`, and `TRIM()` functions

### Gateway Regions
- Standardized gateway region values into uppercase format using `UPPER()`

## Lookup and Enrichment Logic

I performd the following lookup and enrichment operations using supplementary datasets:

- Datasets used:
    1. merchant_master
    2. exchange_rates

### Merchant Enrichment
- Matched `merchant_name` from the transaction dataset with `merchant_master.csv`
- Added `merchant_id` to transaction records using `VLOOKUP()`
- Filled missing `gateway_region` values using the `default_region` field from `merchant_master.csv`

### Currency Conversion
- Used `exchange_rates.csv` for USD conversion rates
- Created a new column `rate_date_and_usd_rate` by combining:
  - `transaction_date`
  - `currency`
- Matched transaction records with exchange rate records using this new column
- Retrieved `usd_rate` using lookup logic
- Converted raw transaction amounts into USD using:
    `amount_usd = ROUND(raw_amount * usd_rate,2)`


## Final Answers

### 1. How many rows are in the dataset before and after cleaning?

- Rows before cleaning: **30**
- Rows after cleaning: **30**

No rows were removed during the cleaning process; only standardization and corrections were applied. I didn't remove one row with missing value in risk_score because 

### 2. How many missing or invalid values were handled?

- Missing values handled: **9**

These included inconsistencies in gateway_region which I handled through enrichment and vlookup using merchant_master dataset.

### 3. How many High Value Transactions (HVT) are there?

- **HVT count: 7**

These transactions represent the higher-value segment based on the pre-defined conditions given in the assignment.

### 4. How many High Risk Transactions (HRT) are there?

- **HRT count: 10**

These transactions were identified based on elevated risk scores indicating potential anomalies or higher probability of failure/fraud as per the pre-defined conditions given in the assignment.

### 5. Who is the top merchant by GMV?

- **Top Merchant: Beta Stores**

Beta Stores contributed the highest total transaction value (GMV), making it the leading merchant in the dataset.

### 6. Which region contributes the highest GMV?

- **Top Region: APAC**

APAC region recorded the highest total GMV, indicating strong transaction activity in this region.


## Formula Samples

### 1. Data Cleaning Formulas

- merchant_name : TRIM(raw_data!C2)

- status : TRIM(raw_data!F2)

- risk_score : TRIM(raw_data!G2)

- gateway_region : TRIM(raw_data!H2)

### 2. Standardization Formulas

- merchant_name : PROPER(TRIM(raw_data!C2))

- status : PROPER(TRIM(raw_data!F2))

- risk_score : IFERROR(VALUE(RIGHT(TRIM(raw_data!G2),2)), "")

- gateway_region : IFERROR(UPPER(TRIM(raw_data!H2)),"")

### 3. Enrichment and Lookup Formulas

- merchant_id : IFERROR(VLOOKUP($C2,merchant_master!$C:$D,2,FALSE),"")

- lookup_key (for currency conversion) : TEXT($B2, "dd-mm-yyyy")&"_"&$F2

- usd_exchnage_rates : VLOOKUP($G2, exchange_rates!$D:$E,2,FALSE)

- amount_usd : ROUND($E2*$H2,2)

- final_gateway_region (filling missing values) : IF(cleaned_data!H3<>"",cleaned_data!H3,VLOOKUP($C2,merchant_master!$C:$E,3,FALSE))

- high_value_flag : IFS(AND($M2="APAC",$I2>5000),1,AND($M2="EU",$I2>6000),1,AND($M2="US",$I2>7000),1,TRUE,0)

- high_risk_flag : IF(OR($K2>70,ISNUMBER(SEARCH("chargeback",$J2))),1,0)