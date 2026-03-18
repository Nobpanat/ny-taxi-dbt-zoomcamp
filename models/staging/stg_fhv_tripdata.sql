select
    -- identifiers
    SAFE_CAST(pulocationid as INT64) as pickup_location_id,
    SAFE_CAST(dolocationid as INT64) as dropoff_location_id,

    -- timestamps
    cast(pickup_datetime as TIMESTAMP) as pickup_datetime,
    cast(dropoff_datetime as TIMESTAMP) as dropoff_datetime,

    dispatching_base_num,
    SR_Flag as sr_flag,
    Affiliated_base_number

from {{ source('raw_data', 'fhv_tripdata') }}
where dispatching_base_num is not null