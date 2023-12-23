-- tenure_engagement_analysis.sql

WITH 
source_customer_data AS (
    SELECT * FROM {{source('customer_data', 'customer_table')}}
),

final AS (
    SELECT * from source_customer_data
),

engagement_data AS (
    SELECT
        Gender,
        CityTier,
        Tenure,
        HourSpendOnApp,
        AVG(CASE WHEN Churn = 0 THEN 1 ELSE 0 END) AS retention_rate
    FROM
        final
    GROUP BY
        Gender, CityTier, Tenure, HourSpendOnApp
)

SELECT
    Gender,
    CityTier,
    Tenure,
    HourSpendOnApp,
    retention_rate
FROM
    engagement_data
ORDER BY
    Gender, CityTier, Tenure, HourSpendOnApp
