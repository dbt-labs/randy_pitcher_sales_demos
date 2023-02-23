
select
    order_month, REGION,
    sum(gross_revenue) as total_revenue

from {{ref('order_details')}}

group by order_month, region
order by order_month desc



