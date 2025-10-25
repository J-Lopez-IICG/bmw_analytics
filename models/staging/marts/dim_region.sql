/*
Modelo de Dimensión: dim_region
---------------------------------
Objetivo: Crear una tabla con una fila única por cada región de venta.
Materialización: Tabla
*/

{{
  config(
    materialized='table'
  )
}}

SELECT
  DISTINCT
  -- Creamos una clave subrogada para la región
  {{ generate_surrogate_key(['region']) }} AS region_id,
  region
FROM
  {{ ref('stg_bmw_sales') }}