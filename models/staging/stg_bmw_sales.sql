/*
Modelo de Staging: stg_bmw_sales
---------------------------------
Objetivo:
1. Limpiar nombres de columnas (snake_case).
2. Estandarizar tipos de datos.
3. Generar una clave subrogada (surrogate key) para identificar cada venta única.
*/

WITH source_data AS (
    SELECT
        CAST(Model AS STRING)                AS model,
        CAST(Year AS INT64)                  AS year,
        CAST(Region AS STRING)               AS region,
        CAST(Color AS STRING)                AS color,
        CAST(Fuel_Type AS STRING)            AS fuel_type,
        CAST(Transmission AS STRING)         AS transmission,
        CAST(Engine_Size_L AS FLOAT64)       AS engine_size_l,
        CAST(Mileage_KM AS INT64)            AS mileage_km,
        CAST(Price_USD AS INT64)             AS price_usd,
        CAST(Sales_Volume AS INT64)          AS sales_volume,
        CAST(Sales_Classification AS STRING) AS sales_classification
    FROM
        -- 'name' y 'table' que definimos en el .yml
        {{ source('raw_bmw_sales', 'bmw_sales_raw') }}
)

SELECT
    -- Generación de Clave Subrogada (Surrogate Key) 
    {{ dbt_utils.generate_surrogate_key(['model', 'year', 'region', 'mileage_km', 'price_usd']) }} AS sale_id,

    -- Seleccionamos el resto de las columnas
    model,
    year,
    region,
    color,
    fuel_type,
    transmission,
    engine_size_l,
    mileage_km,
    price_usd,
    sales_volume,
    sales_classification

FROM
    source_data