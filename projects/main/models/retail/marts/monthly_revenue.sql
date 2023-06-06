
select
    order_month,
    sum(gross_revenue) as total_revenue,
    1 as id

from {{ref('order_details')}}

group by order_month
order by order_month desc



