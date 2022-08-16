
select
    region,
    date_trunc(month, order_date) as order_month,
    sum(gross_item_sales_amount)  as gross_revenue

from 
    {{ref('fct_order_items')}}

group by 
    region,
    order_month

order by 
    order_month,
    region



