-- Q1 Count transactions by status

SELECT
	status,
    COUNT(*) AS transaction_count
FROM
	transaction_cleaned
GROUP BY
	status;

-- Q2 Calculate total captured GMV by merchant

SELECT 
    merchant_name,
    SUM(amount_usd) AS captured_gmv
FROM 
	transaction_cleaned
WHERE 
	status = 'Captured'
GROUP BY 
	merchant_name;

-- Q3 Show top 10 merchants by captured GMV

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

-- Q4 Show daily GMV and successful transaction count

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

-- Q5 Find merchants with chargeback ratio above 1%

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

-- Q6 Find regions with average risk score above 50 and more than 20 transactions

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

-- Q7 Find users with 3 or more failed or chargeback transactions on the same day

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

-- Q8 Show chargeback count, unique affected users, and chargeback amount by merchant

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