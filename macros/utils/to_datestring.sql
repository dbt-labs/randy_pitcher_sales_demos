{% macro to_datestring(date_col) %}
    
    EXTRACT(MONTH FROM {{date_col}})::STRING || '/' || 
    EXTRACT(DAY FROM {{date_col}})::STRING || '/' || 
    EXTRACT(YEAR FROM {{date_col}})::STRING

{% endmacro %}