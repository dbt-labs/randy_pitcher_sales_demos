
select
    order_month,
    nation,
    region,
    customer_market_segment,
    sum(gross_revenue) as total_revenue

from {{ref('order_details')}}

group by all
order by order_month desc



