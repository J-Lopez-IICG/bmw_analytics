-- Este test fallará si encuentra algún año fuera del rango [2010, 2024]

select
    sale_id,
    year
from {{ ref('stg_bmw_sales') }}
where
--Macro personalizado para verificar si el año está en el rango válido
    {{ is_in_valid_year_range('year') }}