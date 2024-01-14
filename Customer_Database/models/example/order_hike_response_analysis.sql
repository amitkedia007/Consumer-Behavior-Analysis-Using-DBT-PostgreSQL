-- order_hike_response_analysis.sql

WITH 
source_customer_data AS (
    SELECT * FROM {{source('customer_data', 'customer_table')}}
),

final AS (
    SELECT * from source_customer_data
),

order_hike_data AS (
    SELECT
        OrderAmountHikeFromlastYear,
        AVG(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) AS churn_rate,
        AVG(OrderCount) AS avg_order_count
    FROM
        final
    GROUP BY
        OrderAmountHikeFromlastYear
)

SELECT
    OrderAmountHikeFromlastYear,
    churn_rate,
    avg_order_count
FROM
    order_hike_data
ORDER BY
    OrderAmountHikeFromlastYear
