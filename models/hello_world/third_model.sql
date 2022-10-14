select 
    processed_at,
    {{ standardize_timestamp('processed_at') }} as processed_at_standardized

from {{ ref('second_model') }}