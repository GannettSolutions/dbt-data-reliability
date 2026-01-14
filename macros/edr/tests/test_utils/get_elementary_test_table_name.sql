{% macro get_elementary_test_table_name() %}
    {% set test_node = model %}
    {% set test_hash = test_node.unique_id.split(".")[-1] %}
    {% set test_name = test_node.name %}
    {% set base_name = "test_{}_{}".format(test_hash, test_name) %}
    {% set max_length = elementary.get_relation_max_name_length() %}
    {% do return(elementary.truncate_table_name_for_max_length(base_name, max_length)) %}
{% endmacro %}
