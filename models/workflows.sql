with workflows as (

    select * from {{ ref('workflows') }}

),

final as (

    select
        *

    from workflows

)

select * from final
