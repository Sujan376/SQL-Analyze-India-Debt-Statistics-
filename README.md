📘 India Debt Analysis Project
Just like individuals, countries also borrow money — but on a much larger scale. Nations like India often take on debt to fund infrastructure, social programs, and economic stability. But with rising liabilities, it becomes essential to ask: Is this debt sustainable?
In this project, we analyze India's external debt and public debt data from 2000 to 2023 using public datasets from The World Bank. The goal is to understand the trends, key sectors contributing to debt, and whether current obligations are manageable.
We'll explore questions like:
1. How has India’s debt changed over time?
2. Which sectors and creditors are responsible for most of the borrowing?
3. Is the short-term debt burden growing?
4. How does India's debt stack up against its GNI and exports?
5. What are the patterns in interest rates and repayment terms?

The analysis combines SQL for querying, Excel for cleaning, and Power BI for dashboarding, creating a complete data pipeline to deliver key insights and recommendations for fiscal strategy.

1. Problem Statement / Objective

a. Analyze how India’s external debt has evolved over time.  
b. Identify major contributing sectors and creditors.  
c. Assess the sustainability of current debt service obligations.  
d. Compare public debt with private and nonguaranteed debt.  
e. Evaluate debt exposure against macroeconomic indicators like GNI and exports.  
f. Understand inflows, repayments, and interest patterns associated with external debt.

2. Data Collection

 Source: [The World Bank International Debt Statistics](https://datatopics.worldbank.org/debt/ids/country/CHN)

3. Data Cleaning & Preparation
a. Removed duplicates and blank entries.  
b. Standardized year format to 4-digit integers.  
c. Replaced missing values (NaN) with 0.  
d. Cleaned and de-duplicated indicator names.  
 Database Normalization
e. Applied a star schema with 6 fact tables + 1 dimension table.  
f. Linked all tables using Indicator_Dimension as the central foreign key.  
g. Key tables:  
   - External_Debt_Overview  
   - Sector_Wise_Debt  
   - Creditors_and_Transactions  
   - Loan_Terms_and_Commitments  
   - Ratios_and_Percentages  
   - TotalDebt  

4. Exploratory Data Analysis (EDA)

a. Grouped 70+ indicators into 6 economic categories.  
b. Handled missing values by replacing NaN with 0.  
c. Analyzed year coverage (2000–2024) for completeness.  
d. Cleaned and unified indicator names across all tables.  
e. Verified numeric formatting for year and value fields.  
f. Detected and reviewed outliers for validity.

5. Feature Engineering & Transformations

a. Created an Indicator_Dimension lookup table for consistency.  
b. Engineered new metrics like:  
   - public_debt_percentage
   - debt_to_gni_ratio
   - net_transfers  
c. Grouped data by year, sector, and indicator for analysis.  
d. Filtered results dynamically using MAX(year) for current insights.  
e. Enabled advanced reporting with time series and KPI dashboards.

6. Analysis / Insights
a. Calculated total external debt, public debt, short-term debt, IMF credit usage via SQL.  
b. Analyzed debt-related ratios for the year 2023 (e.g., reserves to external debt %).  
c. Identified sectors with highest debt burdens.  
d. Used Power BI cards and visuals to display KPIs.  
e. Interpreted risks, trends, and sector dependencies using dashboard insights.

7. Visualization & Dashboarding
a. Built a Power BI dashboard covering 2013–2023.  
b. Visualized:  
   - Total external debt trends  
   - Public vs. private contributions  
   - Short vs. long-term debt  
   - Debt-to-GNI and IMF credit usage  
   - KPIs highlighting risk and sustainability

8. Conclusion
a. India’s external debt has been increasing steadily over the past decade.  
b. Private nonguaranteed debt and short-term liabilities are rising.  
c. Despite growth, debt remains manageable due to strong reserves and moderate debt-to-GNI ratio.

9. Key Takeaways
a. Short-term debt growth should be closely monitored.  
b. Public debt is substantial and should align with fiscal policy.  
c. Negative net transfers in some years signal capital efficiency concerns.

10. Recommendations
a. Enhance dashboards to monitor high-risk KPIs.  
b. Prioritize long-term borrowing over short-term options.  
c. Link future borrowing to GDP performance.  
d. Diversify creditor base and improve borrowing terms.
