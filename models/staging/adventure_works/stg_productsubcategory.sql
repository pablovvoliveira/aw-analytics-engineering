with 

source as (

    select * from {{ source('adventure_works', 'production_productsubcategory') }}

),

renamed as (

    select
        productsubcategoryid,
        productcategoryid,
        name,
        rowguid,
        modifieddate

    from source

)

select * from renamed