
select
    iff(ssn is not null, hash(ssn), null) as ssn_hash,
    name

from {{ ref('pii_customer_details') }}