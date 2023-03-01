
select
    order_month,
    sum(gross_revenue)/0 as total_revenue

from {{ref('order_details')}}

group by order_month
order by order_month desc



