WITH 
source_customer_data AS (
    SELECT * FROM {{source('customer_data', 'customer_table')}}
),

final AS (
    SELECT * from source_customer_data
),

address_data AS (
    SELECT
        NumberOfAddress,
        AVG(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) AS churn_rate,
        AVG(OrderCount) AS avg_order_count
    FROM
        final
    GROUP BY
        NumberOfAddress
)

SELECT
    NumberOfAddress,
    churn_rate,
    avg_order_count
FROM
    address_data
ORDER BY
    NumberOfAddress
