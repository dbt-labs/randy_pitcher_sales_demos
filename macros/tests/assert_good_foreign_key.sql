{% test assert_good_foreign_key(model, column_name, right_model) %}
    {% set left_model=model %}
    {% set left_key=column_name %}
  
    select * from
    {{ left_model }} L left outer join {{ right_model }} R
    on L.{{left_key}} = R.{{left_key}}

    where L.customer_key is null

{% endtest %}