{%- macro standardize_timestamp(timestamp_column) -%}

  to_utc_timestamp({{ timestamp_column }}, 'America/New_York')

{%- endmacro -%}