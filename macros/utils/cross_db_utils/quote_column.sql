
{% macro edr_quote(str) %}
    {% set escaped_str = elementary.escape_special_chars(str) %}
    {% do return("'{}'".format(escaped_str)) %}
{% endmacro %}

{% macro dict_to_quoted_json(d) %}
    {% do return(elementary.edr_cast_as_string(elementary.edr_quote(tojson(d, sort_keys=true)))) %}
{% endmacro %}

{%- macro edr_quote_column(column_name) -%}
    {% if adapter.quote(column_name[1:-1]) == column_name %}
        {{ return(column_name) }}
    {% else %}
        {% set quoted_column = adapter.quote(column_name) %}
        {{ return(quoted_column) }}
    {% endif %}
{%- endmacro -%}


{# this may not be needed MSG did not add dispatch because of not sure its needed #}
{% macro sqlserver__edr_quote_column(column_name) %}
    {# Remove existing brackets if present before re-quoting #}
    {% set clean_column = column_name %}
    {% if column_name.startswith('[') and column_name.endswith(']') %}
        {% set clean_column = column_name[1:-1] %}
    {% elif column_name.startswith('"') and column_name.endswith('"') %}
        {% set clean_column = column_name[1:-1] %}
    {% endif %}
    {{ return(adapter.quote(clean_column)) }}
{% endmacro %}


