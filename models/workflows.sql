create or replace table `owkin-dev-dashboard`.demo.`workflows`
  partition by timestamp_trunc(_airbyte_emitted_at, day)
  cluster by _airbyte_emitted_at
  OPTIONS()
  as (
    
with __dbt__cte__workflows_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: `owkin-dev-dashboard`.demo._airbyte_raw_workflows
select
    *
from `owkin-dev-dashboard`.demo._airbyte_raw_workflows as table_alias
-- workflows
where 1 = 1
),  __dbt__cte__workflows_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__workflows_ab1
select
    *
from __dbt__cte__workflows_ab1
-- workflows
where 1 = 1
),  __dbt__cte__workflows_ab3 as (

-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__workflows_ab2
select
    *
from __dbt__cte__workflows_ab2 tmp
-- workflows
where 1 = 1
)-- Final base SQL model
-- depends_on: __dbt__cte__workflows_ab3
select
    *
from __dbt__cte__workflows_ab3
-- workflows from `owkin-dev-dashboard`.demo._airbyte_raw_workflows
where 1 = 1
  );
