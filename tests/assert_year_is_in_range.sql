-- Este test fallará si encuentra algún año fuera del rango [2010, 2024]

select
    sale_id,
    year
from {{ ref('stg_bmw_sales') }}
where
    -- La columna 'year' ya es numérica gracias al CAST en el modelo de staging.
    year < 2010 or year > 2024