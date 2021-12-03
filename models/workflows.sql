

with workflows as (

    select * from {{ source('Demo', '_airbyte_raw_workflows') }}

),


select * from workflows
