
select
    date_trunc(month, order_date) as order_month,
    sum(gross_revenue)            as gross_revenue

from 
    {{ref('order_details')}}

group by 
    order_month

order by 
    order_month desc



