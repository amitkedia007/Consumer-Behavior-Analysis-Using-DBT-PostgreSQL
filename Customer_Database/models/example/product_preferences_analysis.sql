-- product_preferences_analysis.sql

WITH 
source_customer_data AS (
    SELECT * FROM {{source('customer_data', 'customer_table')}}
),

final AS (
    SELECT * from source_customer_data
),

product_data AS (
    SELECT
        PreferedOrderCat,
        Gender,
        CityTier,
        AVG(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) AS churn_rate,
        AVG(OrderCount) AS avg_order_count,
        COUNT(*) AS total_customers
    FROM
        final
    GROUP BY
        PreferedOrderCat, Gender, CityTier
)

SELECT
    PreferedOrderCat,
    Gender,
    CityTier,
    churn_rate,
    avg_order_count,
    total_customers
FROM
    product_data
ORDER BY
    PreferedOrderCat, Gender, CityTier
