select 
    supplier.supplier_key,
    supplier.supplier_name,
    supplier.supplier_address,
    supplier.phone_number,
    supplier.account_balance,

    nation.name as nation,

    region.name as region

from
    {{ ref('stg_suppliers') }} supplier
    inner join {{ ref('stg_nations') }} nation
        on supplier.nation_key = nation.nation_key
    inner join {{ ref('stg_regions') }} region 
        on nation.region_key = region.region_key
