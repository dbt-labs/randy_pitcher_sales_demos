
select
    order_month, nation, region,
    sum(gross_revenue) as gross_revenue

from {{ref('order_details')}}

group by order_month, nation, region
order by order_month desc, gross_revenue desc



