1️.Trend of External Debt Over Time (2013–2024)
🔹Question: What is the trend of total external debt from 2013 to 2024?
SELECT year, SUM(value) AS total_external_debt
 FROM External_Debt_Overview edo
 JOIN Indicator_Dimension i ON edo.indicator_id = i.id 
 WHERE i.indicator_name ILIKE '%external debt stocks%'
 GROUP BY year ORDER BY year;

2️.Top 5 Contributors to External Debt by Sector (Most Recent Year)
🔹Question: Which sectors had the highest external debt in the latest year?

WITH latest_year AS(
SELECT 
	MAX(year) AS max_year 
FROM 
	Sector_Wise_Debt)
SELECT 
	i.indicator_name, 
	SUM(s.value) AS sector_debt
FROM 
	Sector_Wise_Debt s
JOIN 
	Indicator_Dimension i ON s.indicator_id = i.id
WHERE 
	s.year = (SELECT max_year FROM latest_year)
GROUP BY 
	i.indicator_name
ORDER BY 
	sector_debt DESC
LIMIT 5;

3️.Debt Service vs Net Transfers (Yearly Comparison)
🔹Question:How do debt service payments compare to net transfers annually?
SELECT ct.year,
   SUM(CASE WHEN i.indicator_name ILIKE '%total debt service paid%' THEN ct.value ELSE 0 END) AS total_service,
   SUM(CASE WHEN i.indicator_name ILIKE '%net transfers on external debt%' THEN ct.value ELSE 0 END) AS net_transfers
 FROM Creditors_and_Transactions ct
 JOIN Indicator_Dimension i ON ct.indicator_id = i.id
 GROUP BY ct.year ORDER BY ct.year;
 
4️.Debt to GNI Ratio Trend
🔹Question: How has the external debt to GNI ratio evolved overtime?

SELECT r.year, r.value AS debt_gni_ratio
 FROM Ratios_and_Percentages r
 JOIN Indicator_Dimension i ON r.indicator_id = i.id
 WHERE i.indicator_name ILIKE '%external debt stock to gni%';

5️.Interest vs Maturity: Loan Condition Trends
🔹Question: What are the trends in interest rates and maturity of new loan commitments?

SELECT l.year,
   MAX(CASE WHEN i.indicator_name ILIKE '%interest (%)%' THEN l.value ELSE NULL END) AS interest_rate,
   MAX(CASE WHEN i.indicator_name ILIKE '%maturity (years)%' THEN l.value ELSE NULL END) AS maturity_years
 FROM Loan_Terms_and_Commitments l
 JOIN Indicator_Dimension i ON l.indicator_id = i.id
 GROUP BY l.year ORDER BY l.year;
 

6️.Debt Sustainability Metrics (Recent Year)
🔹Question: What are the key ratios for assessing debt sustainability?

WITH latest_year AS (
    SELECT MAX(year) AS max_year FROM Ratios_and_Percentages
)
SELECT 
    i.indicator_name, 
    r.value, 
    r.year
FROM Ratios_and_Percentages r
JOIN Indicator_Dimension i ON r.indicator_id = i.id
WHERE 
    r.year = (SELECT max_year FROM latest_year)
    AND i.indicator_name IN (
        'External debt stock to exports (%)',
        'External debt stock to GNI (%)',
        'Debt service to exports (%)',
        'Interest payments to exports (%)',
        'Interest payments to GNI (%)',
        'Short-term to external debt stocks (%)',
        'Concessional to external debt stocks (%)',
        'Multilateral to external debt stocks (%)',
        'Reserves to external debt stocks (%)',
        'Reserves to imports (months)'
    );



7: Public Debt Analysis
🔹Question:What is the percentage share of public debt vs total external debt for each year?

SELECT 
    s.year,
    -- Total public debt
    SUM(CASE 
            WHEN i.indicator_name ILIKE '%public and publicly guaranteed%' 
            THEN s.value 
            ELSE 0 
        END)::NUMERIC(10,2) AS public_debt,
    -- Total external debt
    SUM(ed.value)::NUMERIC(10,2) AS external_debt,
    -- % share of public debt
    (
        SUM(CASE 
                WHEN i.indicator_name ILIKE '%public and publicly guaranteed%' 
                THEN s.value 
                ELSE 0 
            END) 
        / NULLIF(SUM(ed.value), 0) * 100
    )::NUMERIC(5,2) AS public_debt_percentage,
    -- % share of external debt (100 - public %)
    (
        (100 - (
            SUM(CASE 
                    WHEN i.indicator_name ILIKE '%public and publicly guaranteed%' 
                    THEN s.value 
                    ELSE 0 
                END) 
            / NULLIF(SUM(ed.value), 0) * 100
        ))
    )::NUMERIC(5,2) AS external_debt_percentage
FROM Sector_Wise_Debt s
JOIN Indicator_Dimension i ON s.indicator_id = i.id
JOIN External_Debt_Overview ed ON ed.year = s.year
JOIN Indicator_Dimension i2 ON ed.indicator_id = i2.id
WHERE 
    i.indicator_name ILIKE '%public and publicly guaranteed%' AND
    i2.indicator_name ILIKE '%external debt stocks%'
GROUP BY s.year
ORDER BY s.year;



8.Which public sector had the highest public debt in the most recent year?
🔹Question: Which public sector category contributed the most to debt in the latest year in India?
	
WITH latest_year AS (
    SELECT MAX(year) AS max_year FROM Sector_Wise_Debt
)
SELECT 
    i.indicator_name, 
    SUM(s.value)::NUMERIC(12,2) AS total_public_debt
FROM Sector_Wise_Debt s
JOIN Indicator_Dimension i ON s.indicator_id = i.id
JOIN latest_year ly ON s.year = ly.max_year
WHERE i.indicator_name ILIKE '%public%'
GROUP BY i.indicator_name
ORDER BY total_public_debt DESC;

9.Short-Term vs Long-Term Debt Over Time

SELECT
    edo.year,
    id.indicator_name,
    SUM(edo.value) AS total_value
FROM
    External_Debt_Overview edo
JOIN
    Indicator_Dimension id ON edo.indicator_id = id.id
WHERE
    id.indicator_name IN ('Short-term external debt', 'Long-term external debt')
GROUP BY
    edo.year, id.indicator_name
ORDER BY
    edo.year, id.indicator_name;

10.Sector-Wise Debt for 2023

SELECT
    id.indicator_name AS sector_name,
    SUM(swd.value) AS total_value
FROM
    Sector_Wise_Debt swd
JOIN
    Indicator_Dimension id ON swd.indicator_id = id.id
WHERE
    swd.year = 2023
GROUP BY
    id.indicator_name
ORDER BY
    total_value DESC;









	





