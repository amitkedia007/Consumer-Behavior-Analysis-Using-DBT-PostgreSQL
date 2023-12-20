-- demographic_analysis

WITH 
source_customer_data AS (
    SELECT * FROM {{source('customer_data', 'customer_table')}}
),

final AS (
    SELECT * from source_customer_data
),

retention_data AS (
    SELECT
        Gender,
        CityTier,
        AVG(CASE WHEN Churn = 0 THEN 1 ELSE 0 END) AS retention_rate
    FROM
        final  
    GROUP BY
        Gender, CityTier
)

SELECT
    Gender,
    CityTier,
    retention_rate
FROM
    retention_data
ORDER BY
    Gender, CityTier
