
select 
    parts.part_key,
    parts.name as part_name,
    parts.manufacturer,
    parts.brand,
    parts.type as part_type,
    parts.size as part_size,
    parts.container,
    parts.retail_price,

    suppliers.supplier_key,
    suppliers.supplier_name,
    suppliers.supplier_address,
    suppliers.phone_number,
    suppliers.account_balance,
    suppliers.nation_key,

    part_suppliers.available_quantity,
    part_suppliers.part_supplier_key,
    part_suppliers.cost

from
    {{ ref('stg_parts') }} parts 
    inner join 
    {{ ref('stg_part_suppliers') }} part_suppliers on parts.part_key = part_suppliers.part_key
    inner join
    {{ ref('stg_suppliers') }} suppliers on part_suppliers.supplier_key = suppliers.supplier_key

order by
    parts.part_key
