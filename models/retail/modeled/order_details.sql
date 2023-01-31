select
    *

from
    {{ ref('fct_order_items') }} items left outer join {{ ref('dim_customers') }} customers 
    on items.customer_key = customers.customer_key