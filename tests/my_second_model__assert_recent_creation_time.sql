{{ config(severity='warn') }}

select 
    * 

from {{ref('my_second_model')}}

where created_at < current_timestamp