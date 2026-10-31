-- ==========================================
-- 2. EXPLORATORY DATA ANALYSIS & INSIGHTS
-- ==========================================

-- Summary statistics for numerical columns
SELECT 
    MIN(tenure) AS min_tenure,
    MAX(tenure) AS max_tenure,
    ROUND(AVG(tenure), 2) AS avg_tenure,
    MIN(monthlycharges) AS min_monthly,
    MAX(monthlycharges) AS max_monthly,
    ROUND(AVG(monthlycharges), 2) AS avg_monthly,
    MIN(totalcharges) AS min_total,
    MAX(totalcharges) AS max_total,
    ROUND(AVG(totalcharges), 2) AS avg_total
FROM raw_telco;

-- Overall churn rate percentage
SELECT 
    COUNT(churn) AS total_customers,
    COUNT(churn) FILTER (WHERE churn = 'Yes') AS churned_customers,
    ROUND(COUNT(churn) FILTER (WHERE churn = 'Yes')::NUMERIC / COUNT(*) * 100, 2) AS percent_of_churned
FROM raw_telco;

-- Churn rate breakdown by contract type
SELECT 
    contract,
    COUNT(contract) AS total_per_contract,
    COUNT(contract) FILTER (WHERE churn = 'Yes') AS churned_per_contract,
    ROUND((COUNT(contract) FILTER (WHERE churn = 'Yes')::NUMERIC / COUNT(contract)::NUMERIC) * 100, 2) AS percent_of_churned_per_contract
FROM raw_telco
GROUP BY contract
ORDER BY percent_of_churned_per_contract DESC;

-- Churn rate breakdown by payment method
SELECT 
    paymentmethod,
    COUNT(paymentmethod) AS total_per_paymentmethod,
    COUNT(paymentmethod) FILTER (WHERE churn = 'Yes') AS churned_per_paymentmethod,
    ROUND((COUNT(paymentmethod) FILTER (WHERE churn = 'Yes')::NUMERIC / COUNT(paymentmethod)::NUMERIC) * 100, 2) AS percent_of_churned_per_paymentmethod
FROM raw_telco
GROUP BY paymentmethod
ORDER BY percent_of_churned_per_paymentmethod DESC;

-- Churn rate breakdown by internet service type
SELECT 
    internetservice,
    COUNT(internetservice) AS total_per_internetservice,
    COUNT(internetservice) FILTER (WHERE churn = 'Yes') AS churned_per_internetservice,
    ROUND((COUNT(internetservice) FILTER (WHERE churn = 'Yes')::NUMERIC / COUNT(internetservice)::NUMERIC) * 100, 2) AS percent_of_churned_per_internetservice
FROM raw_telco
GROUP BY internetservice
ORDER BY percent_of_churned_per_internetservice DESC;

-- Average monthly charges compared by payment method and churn status
SELECT 
    paymentmethod,
    ROUND(AVG(monthlycharges) FILTER (WHERE churn = 'Yes'), 2) AS average_bill_yes,
    ROUND(AVG(monthlycharges) FILTER (WHERE churn = 'No'), 2) AS average_bill_no
FROM raw_telco
GROUP BY paymentmethod;

-- Churn rate percentage based on technical support availability
SELECT 
    techsupport,
    COUNT(techsupport) FILTER (WHERE churn = 'Yes') AS left_per_techsupport,
    ROUND((COUNT(techsupport) FILTER (WHERE churn = 'Yes')::NUMERIC / COUNT(*) * 100), 2) AS percent_per_techsupport
FROM raw_telco
GROUP BY techsupport
ORDER BY percent_per_techsupport DESC;