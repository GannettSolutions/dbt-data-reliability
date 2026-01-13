{% macro boolean(value) %}
  {{ return(adapter.dispatch('boolean', 'elementary')(value)) }}
{% endmacro %}


{% macro default__boolean(value) %}
  {% if value %}
    TRUE
  {% else %}
    FALSE
  {% endif %}
{% endmacro %}


{% macro sqlserver__boolean(value) %}
  {% if value %}
    1
  {% else %}
    0
  {% endif %}
{% endmacro %}

{% macro boolean_predicate(value) %}
  {{ return(adapter.dispatch('boolean_predicate', 'elementary')(value)) }}
{% endmacro %}

{% macro default__boolean_predicate(value) %}
  {{ elementary.boolean(value) }}
{% endmacro %}

{% macro sqlserver__boolean_predicate(value) %}
  {{ elementary.boolean(value) }} = {{ elementary.boolean(true) }}
{% endmacro %}

