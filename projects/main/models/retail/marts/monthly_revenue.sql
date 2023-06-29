
select
    customer_market_segment, region, order_month,
    sum(gross_revenue) as total_revenue

from {{ref('order_details')}}

group by order_month, customer_market_segment, region



