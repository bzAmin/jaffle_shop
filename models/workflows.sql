

with workflows as (

    select * from {{ ref('stg_orders') }}

),


select * from workflows
