
select
    order_month,
    region,
    nation,
    sum(gross_revenue) as total_revenue

from {{ref('order_details')}}

group by order_month, region, nation
order by order_month desc, region desc, nation



