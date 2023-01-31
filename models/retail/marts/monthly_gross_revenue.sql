
select
    date_trunc(month, order_date) as order_month,
    sum(gross_revenue)            as gross_revenue,
    region, nation

from 
    {{ref('order_details')}}

group by 
    order_month, region, nation

order by 
    order_month desc, gross_revenue desc



