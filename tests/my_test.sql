
select * from
{{ ref('fct_order_items') }} f left outer join {{ ref('dim_customers') }} d
on f.customer_key = d.customer_key

where d.customer_key is null