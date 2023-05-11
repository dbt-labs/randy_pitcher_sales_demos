select
    order_date,
    gross_revenue as revenue,
    customer_market_segment

from {{ ref('order_details') }}