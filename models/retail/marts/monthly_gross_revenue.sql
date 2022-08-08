
select
    ship_date as day,
    sum(extended_price) as total_price
from 
    {{ref('order_items')}}

group by day



