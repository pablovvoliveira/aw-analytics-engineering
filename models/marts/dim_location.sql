{{ config(materialized='table') }}

with address as (
    select * from {{ ref('stg_address') }}
),

stateprovince as (
    select * from {{ ref('stg_stateprovince') }}
),

countryregion as (
    select * from {{ ref('stg_countryregion') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['address.addressid']) }} as sk_location,
    address.addressid,
    address.city,
    stateprovince.name as state_name,
    countryregion.name as country_name
from address
left join stateprovince
    on address.stateprovinceid = stateprovince.stateprovinceid
left join countryregion
    on stateprovince.countryregioncode = countryregion.countryregioncode