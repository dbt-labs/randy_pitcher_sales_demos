select
    order_date,
    gross_revenue as revenue,
    customer_market_segment

from {{ ref('order_details') }}

-- last 6 months of data
where order_date > dateadd(month, -6, current_date)