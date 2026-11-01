{{ config(materialized='table') }}

with creditcard as (
    select
        creditcardid,
        cardtype
    from {{ ref('stg_creditcard') }}
),

no_card as (
    select
        cast(null as int) as creditcardid,
        'Sem cartão' as cardtype
)

select
    {{ dbt_utils.generate_surrogate_key(['creditcardid']) }} as sk_creditcard,
    creditcardid,
    cardtype
from (
    select * from creditcard
    union all
    select * from no_card
)