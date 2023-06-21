
select
    customer_market_segment, region,
    sum(gross_revenue) as total_revenue

from {{ref('order_details')}}

group by customer_market_segment, region



