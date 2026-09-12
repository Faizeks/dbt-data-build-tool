{% macro full_name(first_name, last_name) %}

    trim(concat({{ first_name }}, ' ', {{ last_name }}))

{% endmacro %}