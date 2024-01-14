-- payment_mode_preferences_analysis.sql

WITH 
source_customer_data AS (
    SELECT * FROM {{source('customer_data', 'customer_table')}}
),

final AS (
    SELECT * from source_customer_data
),

payment_mode_data AS (
    SELECT
        PreferredPaymentMode,
        AVG(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) AS churn_rate,
        AVG(OrderCount) AS avg_order_count,
        AVG(CashbackAmount) AS avg_cashback_amount
    FROM
        final
    GROUP BY
        PreferredPaymentMode
)

SELECT
    PreferredPaymentMode,
    churn_rate,
    avg_order_count,
    avg_cashback_amount
FROM
    payment_mode_data
ORDER BY
    PreferredPaymentMode
