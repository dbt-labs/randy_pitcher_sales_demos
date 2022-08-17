select 
    now                                as now,
    {{ standardize_timestamp('now') }} as now_standardized

from {{ ref('second_model') }}