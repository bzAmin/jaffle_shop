create or replace table `owkin-dev-dashboard`.demo.`workflows`
  partition by timestamp_trunc(_airbyte_emitted_at, day)
  cluster by _airbyte_emitted_at
  OPTIONS()
  as (
    
with __dbt__cte__workflows_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: `owkin-dev-dashboard`.demo._airbyte_raw_workflows
select
    json_extract_array(_airbyte_data, "$['workflows']") as workflows,
    json_extract_scalar(_airbyte_data, "$['total_count']") as total_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at
from `owkin-dev-dashboard`.demo._airbyte_raw_workflows as table_alias
-- workflows
where 1 = 1
),  __dbt__cte__workflows_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__workflows_ab1
select
    workflows,
    cast(total_count as 
    int64
) as total_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at
from __dbt__cte__workflows_ab1
-- workflows
where 1 = 1
),  __dbt__cte__workflows_ab3 as (

-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__workflows_ab2
select
    to_hex(md5(cast(concat(coalesce(cast(array_to_string(workflows, "|", "") as 
    string
), ''), '-', coalesce(cast(total_count as 
    string
), '')) as 
    string
))) as _airbyte_workflows_hashid,
    tmp.*
from __dbt__cte__workflows_ab2 tmp
-- workflows
where 1 = 1
)-- Final base SQL model
-- depends_on: __dbt__cte__workflows_ab3
select
    workflows,
    total_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at,
    _airbyte_workflows_hashid
from __dbt__cte__workflows_ab3
-- workflows from `owkin-dev-dashboard`.demo._airbyte_raw_workflows
where 1 = 1
  );
