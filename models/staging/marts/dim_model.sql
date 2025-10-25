/*
Modelo de Dimensión: dim_model
---------------------------------
Objetivo: Crear una tabla con una fila única por cada combinación de 
          atributos que definen un vehículo.
Materialización: Tabla
*/

-- Configuración para materializar como tabla
{{
  config(
    materialized='table'
  )
}}

WITH model_data AS (
  SELECT DISTINCT
    -- Seleccionamos los atributos descriptivos del vehículo
    model,
    year,
    fuel_type,
    transmission,
    engine_size_l,
    color
  FROM
    -- Usamos {{ ref }} para construir sobre nuestra capa staging
    {{ ref('stg_bmw_sales') }}
)

SELECT
  -- Creamos una clave subrogada (Surrogate Key) para esta dimensión.
  -- Esta será la 'model_id' que usaremos en la tabla de hechos.
  {{ generate_surrogate_key(
      ['model', 'year', 'fuel_type', 'transmission', 'engine_size_l', 'color']
  ) }} AS model_id,

  model,
  year,
  fuel_type,
  transmission,
  engine_size_l,
  color

FROM
  model_data