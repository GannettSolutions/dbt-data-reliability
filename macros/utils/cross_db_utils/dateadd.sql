
{% macro edr_dateadd(datepart, interval, from_date_or_timestamp) -%}
    {{ return(adapter.dispatch('edr_dateadd', 'elementary')(datepart, interval, from_date_or_timestamp)) }}
{%- endmacro %}




{% macro default__edr_dateadd(datepart, interval, from_date_or_timestamp) %}
    {% set macro = dbt.dateadd or dbt_utils.dateadd %}
    {% if not macro %}
        {{ exceptions.raise_compiler_error("Did not find a `dateadd` macro.") }}
    {% endif %}
    {{ return(macro(datepart, interval, from_date_or_timestamp)) }}
{% endmacro %}



{% macro sqlserver__edr_dateadd(datepart, interval, from_date_or_timestamp) %}
    {% set datepart = datepart | lower %}
    {% set expr = "cast(" ~ from_date_or_timestamp ~ " as datetime)" %}
    {{ return("dateadd(" ~ datepart ~ ", " ~ interval ~ ", " ~ expr ~ ")") }}
{% endmacro %}


{% macro duckdb__edr_dateadd(datepart, interval, from_date_or_timestamp) %}
    {{ return("date_add('" ~ datepart ~ "', " ~ interval ~ ", " ~ from_date_or_timestamp ~ ")") }}
{% endmacro %}
