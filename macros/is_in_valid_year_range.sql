{% macro is_in_valid_year_range(year_column) %}
    {{ year_column }} < 2010 or {{ year_column }} > 2024
{% endmacro %}
