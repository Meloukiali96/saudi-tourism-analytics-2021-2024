--Growth Trends
SELECT 
YEARS,
Province,
Tourism_Type,
ROUND(SUM(Tourists_Number)::numeric, 0) AS Total_Tourists,
ROUND(SUM(Tourists_Spending)::numeric, 0) AS Total_Spending,
LAG(ROUND(SUM(Tourists_Number)::numeric, 0)) OVER (
PARTITION BY Province, Tourism_Type ORDER BY YEARS
) AS Prev_Tourists,
ROUND(
(
SUM(Tourists_Number)::numeric - 
LAG(SUM(Tourists_Number)::numeric) OVER (PARTITION BY Province, Tourism_Type ORDER BY YEARS)
) / NULLIF(LAG(SUM(Tourists_Number)::numeric) OVER (PARTITION BY Province, Tourism_Type ORDER BY YEARS),0) * 100, 
1) AS Growth_Tourists_Percent
FROM Tourism_Data
WHERE YEARS BETWEEN 2021 AND 2024
GROUP BY YEARS, Province, Tourism_Type;


--ADR Trends by Province
SELECT 
YEARS,
Province,
Accommodation_Type,
ROUND(AVG(Avg_ADR)::numeric, 0) AS Avg_ADR
FROM ADR_Data
WHERE YEARS BETWEEN 2021 AND 2024
GROUP BY YEARS, Province, Accommodation_Type
ORDER BY Province, YEARS, Accommodation_Type;


--Top 5 Provinces by Tourist Spending (2021–2024)
SELECT 
Province,
ROUND(SUM(Tourists_Spending)::numeric, 0) AS Total_Spending_SAR
FROM Tourism_Data
WHERE YEARS BETWEEN 2021 AND 2024
GROUP BY Province
ORDER BY Total_Spending_SAR DESC
LIMIT 5;


--Inbound vs Domestic Comparison
SELECT 
    YEARS,
    Tourism_Type,
    ROUND(SUM(Tourists_Number)::numeric, 0) AS Total_Tourists,
    ROUND(SUM(Tourists_Spending)::numeric, 0) AS Total_Spending_SAR
FROM Tourism_Data
WHERE YEARS BETWEEN 2021 AND 2024
GROUP BY YEARS, Tourism_Type
ORDER BY YEARS, Tourism_Type;


--Spending Efficiency (Avg Spend per Trip & per Night)
SELECT 
YEARS,
Province,
ROUND(AVG(Avg_Spending_Trip)::numeric, 0) AS Avg_Spending_Trip,
ROUND(AVG(Avg_Spending_Night)::numeric, 0) AS Avg_Spending_Night
FROM Tourism_Data
WHERE YEARS BETWEEN 2021 AND 2024
GROUP BY YEARS, Province
ORDER BY YEARS, Province;



