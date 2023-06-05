
select
    iff(ssn is not null, hash(ssn), null) as ssn_hash,
    substr(first_name, 1, 1) || '. ' || last_name as name,
    state,
    zodiac,
    phone is not null as has_phone_number

from {{ ref('pii_customer_details') }}