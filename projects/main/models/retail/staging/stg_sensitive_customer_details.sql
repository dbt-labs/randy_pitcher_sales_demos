select * 

from {{ source('sanitized_sensitive_data', 'sanitized_customer_details') }}