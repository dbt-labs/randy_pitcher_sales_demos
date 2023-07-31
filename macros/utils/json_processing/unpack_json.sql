{%- macro unpack_json(model, variant_column_name, column_prefix='') -%}

  {% set prefix = column_prefix ~ '_' if column_prefix else '' %}
  {%- set variant_keys_query -%}
    WITH 

    KEYS AS (
      SELECT 
        OBJECT_KEYS({{variant_column_name}})
      FROM {{model}}
      limit 1 -- it can be expensive to check every record for every set of keys. Let's just take the first record returned
    )

    SELECT 
      K.VALUE::STRING
    
    FROM TABLE(FLATTEN(INPUT => (SELECT * FROM KEYS))) K
  {%- endset -%}

  {%- if execute -%}
    {%- set keys = run_query(variant_keys_query).columns[0].values() -%}

    {% for key in keys %}
        GET({{variant_column_name}}, '{{key}}') AS {{prefix}}{{key}}{%- if not loop.last -%}, {%- endif -%}
    {% endfor %}

  {%- else -%}
    {{ return('NULL')}}
  {%- endif -%}


{%- endmacro -%}