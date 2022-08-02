select 
    part.part_key,
    part.name as part_name,
    part.manufacturer,
    part.brand,
    part.type as part_type,
    part.size as part_size,
    part.container,
    part.retail_price,

    part_supplier.available_quantity,
    part_supplier.part_supplier_key,
    part_supplier.cost,

    supplier.supplier_key,
    supplier.supplier_name,
    supplier.supplier_address,
    supplier.phone_number,
    supplier.account_balance,
    supplier.nation_key

from
    {{ ref('stg_parts') }} part
    inner join 
    {{ ref('stg_part_suppliers') }} part_supplier on part.part_key = part_supplier.part_key
    inner join
    {{ ref('stg_suppliers') }} supplier on part_supplier.supplier_key = supplier.supplier_key
