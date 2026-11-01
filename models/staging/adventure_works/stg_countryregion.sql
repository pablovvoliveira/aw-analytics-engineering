with 

source as (

    select * from {{ source('adventure_works', 'person_countryregion') }}

),

renamed as (

    select
        countryregioncode,
        name,
        modifieddate

    from source

)

select * from renamed