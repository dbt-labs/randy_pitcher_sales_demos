select
    traffic_at::timestamp_ntz as traffic_time,
    count_of_traffic_events  as requests

from {{ ref('stg_application_tracking_history') }}