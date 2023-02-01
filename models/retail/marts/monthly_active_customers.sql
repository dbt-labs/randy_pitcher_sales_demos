
select *
from {{ metrics.calculate(metric("total_active_customers"), grain="month") }}
