{% test not_negative(model, column_name) %}
{#
This is the standard implementation of the not_negative test.
We are adding it locally to work around a dbt environment issue.
#}
select *
from {{ model }}
where {{ column_name }} < 0

{% endtest %}