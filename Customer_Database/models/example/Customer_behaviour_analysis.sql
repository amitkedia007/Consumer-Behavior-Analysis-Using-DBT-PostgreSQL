-- customer_behavior_analysis.sql

WITH 
source_customer_data AS (
    SELECT * FROM {{source('customer_data', 'customer_table')}}
),

final AS (
    SELECT * from source_customer_data
),

customer_behavior AS (
    SELECT
        Gender,
        CityTier,
        AVG(OrderCount) AS avg_order_count,
        AVG(CashbackAmount) AS avg_cashback_amount,
        AVG(CouponUsed) AS avg_coupon_used,
        AVG(SatisfactionScore) AS avg_satisfaction_score,
        COUNT(*) AS total_customers
    FROM
        final 
    WHERE
        Churn = 0  -- Focusing on retained customers
    GROUP BY
        Gender, CityTier
)

SELECT
    Gender,
    CityTier,
    avg_order_count,
    avg_cashback_amount,
    avg_coupon_used,
    avg_satisfaction_score,
    total_customers
FROM
    customer_behavior
ORDER BY
    Gender, CityTier
