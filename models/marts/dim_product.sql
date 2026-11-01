{{ config(materialized='table') }}

with product as (
    select * from {{ ref('stg_product') }}
),

subcategory as (
    select * from {{ ref('stg_productsubcategory') }}
),

category as (
    select * from {{ ref('stg_productcategory') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['product.productid']) }} as sk_product,
    product.productid,
    product.name as product_name,
    subcategory.name as product_subcategory,
    category.name as product_category
from product
left join subcategory
    on product.productsubcategoryid = subcategory.productsubcategoryid
left join category
    on subcategory.productcategoryid = category.productcategoryid