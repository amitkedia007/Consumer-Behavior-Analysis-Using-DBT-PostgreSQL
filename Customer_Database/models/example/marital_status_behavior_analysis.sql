-- marital_status_behavior_analysis.sql
WITH 
source_customer_data AS (
    SELECT * FROM {{source('customer_data', 'customer_table')}}
),

final AS (
    SELECT * from source_customer_data
),

marital_status_data AS (
    SELECT
        MaritalStatus,
        AVG(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) AS churn_rate,
        AVG(OrderCount) AS avg_order_count,
        AVG(CashbackAmount) AS avg_cashback_amount
    FROM
       final
    GROUP BY
        MaritalStatus
)

SELECT
    MaritalStatus,
    churn_rate,
    avg_order_count,
    avg_cashback_amount
FROM
    marital_status_data
ORDER BY
    MaritalStatus
