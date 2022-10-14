select 
    processed_at                                as processed_at,
    {{ standardize_timestamp('processed_at') }} as processed_at

from {{ ref('second_model') }}