
select
    order_month, customer_market_segment,
    sum(gross_revenue) as total_revenue

from {{ref('order_details')}}

group by order_month, customer_market_segment
order by order_month desc



