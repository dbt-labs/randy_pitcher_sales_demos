
select
    order_month,
    customer_key::string as customer_key,
    customer_name,
    nation,
    region,
    customer_market_segment,
    sum(gross_revenue) as total_revenue

from {{ref('order_details')}}

group by all
order by order_month desc



