-- ==========================================
-- 1. DATA CLEANING & PREPARATION
-- ==========================================

-- Check for duplicates in the customerid column
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customerid) AS unique_customers
FROM raw_telco;

-- Check for missing or empty values in key columns
SELECT customerid, tenure, monthlycharges, totalcharges
FROM raw_telco
WHERE tenure IS NULL OR TRIM(tenure::text) = '';

SELECT customerid, tenure, monthlycharges, totalcharges
FROM raw_telco
WHERE monthlycharges IS NULL OR TRIM(monthlycharges::text) = '';

SELECT customerid, tenure, monthlycharges, totalcharges
FROM raw_telco
WHERE totalcharges IS NULL OR TRIM(totalcharges::text) = '';

-- Set totalcharges to '0' where fields are empty
UPDATE raw_telco
SET totalcharges = '0'
WHERE totalcharges IS NULL OR TRIM(totalcharges::text) = '';

-- Change column data types from VARCHAR to INTEGER / NUMERIC
ALTER TABLE raw_telco
ALTER COLUMN tenure TYPE INTEGER
USING tenure::INTEGER;

ALTER TABLE raw_telco
ALTER COLUMN monthlycharges TYPE NUMERIC
USING monthlycharges::NUMERIC;

ALTER TABLE raw_telco
ALTER COLUMN totalcharges TYPE NUMERIC
USING totalcharges::NUMERIC;

ALTER TABLE raw_telco
ALTER COLUMN seniorcitizen TYPE INTEGER
USING seniorcitizen::INTEGER;

-- Add constraints to ensure valid domain values
ALTER TABLE raw_telco
ADD CONSTRAINT chk_seniorcitizen_binary CHECK (seniorcitizen IN (0, 1));

ALTER TABLE raw_telco
ADD CONSTRAINT chk_partner CHECK (partner IN ('Yes', 'No'));

ALTER TABLE raw_telco
ADD CONSTRAINT chk_dependents CHECK (dependents IN ('Yes', 'No'));

ALTER TABLE raw_telco
ADD CONSTRAINT chk_churn CHECK (churn IN ('Yes', 'No'));