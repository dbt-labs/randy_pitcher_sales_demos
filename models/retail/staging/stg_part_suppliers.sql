select
    {{ dbt_utils.surrogate_key(['part_key', 'supplier_key']) }} as part_supplier_key,
    ps_partkey                                                  as part_key,
    ps_suppkey                                                  as supplier_key,
    ps_availqty                                                 as available_quantity,
    ps_supplycost                                               as cost,
    ps_comment                                                  as comment

from 
    {{ source('retail', 'partsupp') }}