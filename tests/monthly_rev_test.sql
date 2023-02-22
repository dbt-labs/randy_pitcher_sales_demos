select * from {{ ref('monthly_revenue') }}

where order_month = null