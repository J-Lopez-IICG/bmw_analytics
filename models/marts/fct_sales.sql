    /*
    Modelo de Hechos: fct_sales
    ---------------------------------
    Objetivo: Crear una tabla central con una fila por venta, conteniendo
            las métricas de negocio y las claves foráneas a las dimensiones.
    Materialización: Tabla
    */

    {{
    config(
        materialized='table'
    )
    }}

    -- Paso 1: Importar la capa de staging (nuestros datos limpios)
    WITH stg_sales AS (
        SELECT *
        FROM {{ ref('stg_bmw_sales') }}
    ),

    -- Paso 2: Importar la dimensión de modelos
    dim_model AS (
        SELECT *
        FROM {{ ref('dim_model') }}
    ),

    -- Paso 3: Importar la dimensión de regiones
    dim_region AS (
        SELECT *
        FROM {{ ref('dim_region') }}
    )

    -- Paso 4: Unir (JOIN) los hechos (staging) con las dimensiones
    SELECT
        -- Clave Primaria (del staging)
        stg_sales.sale_id,

        -- Claves Foráneas (de las dimensiones)
        dim_model.model_id,
        dim_region.region_id,

        -- Métricas (Hechos)
        stg_sales.price_usd,
        stg_sales.mileage_km,
        stg_sales.sales_volume

    FROM
        stg_sales

    -- Unimos con dim_model usando la "llave de negocio"
    LEFT JOIN dim_model
        ON stg_sales.model = dim_model.model
        AND stg_sales.year = dim_model.year
        AND stg_sales.fuel_type = dim_model.fuel_type
        AND stg_sales.transmission = dim_model.transmission
        AND stg_sales.engine_size_l = dim_model.engine_size_l
        AND stg_sales.color = dim_model.color

    -- Unimos con dim_region usando la "llave de negocio"
    LEFT JOIN dim_region
        ON stg_sales.region = dim_region.region