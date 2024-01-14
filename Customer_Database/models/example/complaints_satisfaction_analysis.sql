WITH 
source_customer_data AS(
    SELECT * FROM {{source('customer_data', 'customer_table')}}
),

final AS (
    SELECT * FROM source_customer_data
),

complaints_satisfaction_data AS (
    SELECT 
        Gender,
        CityTier,
        Complain,
        SatisfactionScore,
        AVG(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) AS churn_rate
    FROM
        final
    GROUP BY
        Gender, CityTier, Complain, SatisfactionScore
)

SELECT 
    Gender,
    CityTier,
    Complain,
    SatisfactionScore,
    churn_rate
FROM
    complaints_satisfaction_data
ORDER BY
    Gender, CityTier, Complain, SatisfactionScore



