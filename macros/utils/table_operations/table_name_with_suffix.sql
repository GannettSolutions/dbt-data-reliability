{% macro table_name_with_suffix(table_name, suffix) %}
    {% set full_name = table_name ~ suffix %}
    {% set max_length = elementary.get_relation_max_name_length() %}
    {{ return(elementary.truncate_table_name_for_max_length(full_name, max_length)) }}
{% endmacro %}
