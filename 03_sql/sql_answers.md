# SQL Answers

## Q1 Count transactions by status

### Query

SELECT
	status,
    COUNT(*) AS transaction_count
FROM
	transaction_cleaned
GROUP BY
	status;

### Result Summary

| status             | transaction_count |
|--------------------|-------------------|
| Captured           | 19                |
| Failed E05 Timeout | 7                 |
| Chargeback         | 4                 |

The transactions are mostly successful, with Captured (19) being the dominant status. However, there is a noticeable portion of failures (7 timeout failures) and 4 chargebacks, indicating some operational and risk-related issues in transaction processing.

## Q2 Calculate total captured GMV by merchant

### Query

SELECT 
    merchant_name,
    SUM(amount_usd) AS captured_gmv
FROM 
	transaction_cleaned
WHERE 
	status = 'Captured'
GROUP BY 
	merchant_name;

### Result Summary

| merchant_name | captured_gmv |
|---------------|--------------|
| Alpha Mart    | 29985        |
| Beta Stores   | 33431        |
| City Pharma   | 8640         |
| Delta Travels | 10300        |

Among successful transactions, Beta Stores and Alpha Mart contribute the highest captured GMV, indicating they are the strongest revenue-driving merchants in the dataset.

## Q3 Show top 10 merchants by captured GMV

### Query

SELECT 
    merchant_name,
    SUM(amount_usd) AS captured_gmv
FROM 
	transaction_cleaned
WHERE 
	status = 'Captured'
GROUP BY 
	merchant_name
ORDER BY 
	captured_gmv DESC
LIMIT 10;

### Result Summary

| merchant_name | captured_gmv |
|---------------|--------------|
| Beta Stores   | 33431        |
| Alpha Mart    | 29985        |
| Delta Travels | 10300        |
| City Pharma   | 8640         |

Ranking captured GMV confirms Beta Stores as the top-performing merchant, followed by Alpha Mart. This highlights a clear revenue concentration among top merchants.

## Q4 Show daily GMV and successful transaction count

### Query

SELECT 
    transaction_date,
    SUM(amount_usd) AS daily_gmv,
    COUNT(*) AS successful_transactions
FROM 
	transaction_cleaned
WHERE 
	status = 'Captured'
GROUP BY 
	transaction_date
ORDER BY 
	transaction_date;

### Result Summary

| transaction_date | daily_gmv | successful_transactions |
|------------------|-----------|-------------------------|
| 01-03-2026       | 26382     | 5                       |
| 02-03-2026       | 11080     | 3                       |
| 03-03-2026       | 16032     | 4                       |
| 04-03-2026       | 13920     | 4                       |
| 05-03-2026       | 6136      | 1                       |
| 06-03-2026       | 8806      | 2                       |

Daily GMV shows a declining trend over time, with the highest activity on 01-03-2026 and significantly lower volumes by 05-03-2026, indicating fluctuating transaction demand across days.

## Q5 Find merchants with chargeback ratio above 1%

### Query

SELECT 
    merchant_name,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN status = 'Chargeback' THEN 1 ELSE 0 END) 
        AS chargebacks,
    (SUM(CASE WHEN status = 'Chargeback' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) 
        AS chargeback_ratio
FROM 
    transaction_cleaned
GROUP BY 
    merchant_name
HAVING 
    chargeback_ratio > 1;

### Result Summary

| merchant_name | total_transactions | chargebacks | chargeback_ratio |
|---------------|--------------------|-------------|------------------|
| Alpha Mart    | 11                 | 1           | 9.09091          |
| Beta Stores   | 11                 | 1           | 9.09091          |
| Eco Home      | 2                  | 1           | 50               |
| Delta Travels | 4                  | 1           | 25               |

Several merchants show elevated chargeback ratios, with Eco Home (50%) and Delta Travels (25%) being the most risky. This indicates potential fraud or service issues within specific merchant segments.

## Q6 Find regions with average risk score above 50 and more than 20 transactions

### Query

SELECT 
    gateway_region,
    AVG(risk_score) AS avg_risk_score,
    COUNT(*) AS transaction_count
FROM 
	transaction_cleaned
GROUP BY 
	gateway_region
HAVING 
	AVG(risk_score) > 50
	AND 
	COUNT(*) > 20;

### Result Summary

| gateway_region | avg_risk_score | transaction_count |
|----------------|----------------|-------------------|
| APAC           | 65.75          | 21                |

The APAC region shows a high average risk score (65.75) with sufficient transaction volume, indicating it is the primary high-risk operational region in this dataset.

## Q7 Find users with 3 or more failed or chargeback transactions on the same day

### Query

SELECT 
    user_id,
    transaction_date,
    COUNT(*) AS bad_transactions
FROM 
	transaction_cleaned
WHERE 
	status IN ('Failed E05 Timeout', 'Chargeback')
GROUP BY 
	user_id, transaction_date
HAVING 
	COUNT(*) >= 3;

### Result Summary

| user_id | transaction_date | bad_transactions |
|---------|------------------|------------------|
| U008    | 05-03-2026       | 4                |

User U008 shows a spike in bad transactions (failed + chargebacks) on 05-03-2026, suggesting potential suspicious or unstable user behavior on that date.

## Q8 Show chargeback count, unique affected users, and chargeback amount by merchant

### Query

SELECT 
    merchant_name,
    SUM(CASE WHEN status = 'Chargeback' THEN 1 ELSE 0 END) 
        AS chargeback_count,
    COUNT(DISTINCT CASE WHEN status = 'Chargeback' THEN user_id END) 
        AS affected_users,
    SUM(CASE WHEN status = 'Chargeback' THEN amount_usd ELSE 0 END) 
        AS chargeback_amount
FROM 
	transaction_cleaned
GROUP BY 
	merchant_name;

### Result Summary

| merchant_name | chargeback_count | affected_users | chargeback_amount |
|---------------|------------------|----------------|-------------------|
| Alpha Mart    | 1                | 1              | 5400              |
| Beta Stores   | 1                | 1              | 1711              |
| City Pharma   | 0                | 0              | 0                 |
| Delta Travels | 1                | 1              | 2500              |
| Eco Home      | 1                | 1              | 6649              |

Chargebacks are concentrated across a few merchants, with Eco Home having the highest financial impact (6649 USD) despite low frequency, indicating high-value dispute exposure risk.