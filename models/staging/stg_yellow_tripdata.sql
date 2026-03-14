SELECT 
    -- identifiers (standardized naming for consistency across yellow/green)
    cast(vendorid as INT64) as vendor_id,
    cast(ratecodeid as INT64) as rate_code_id,
    cast(pulocationid as INT64) as pickup_location_id,
    cast(dolocationid as INT64) as dropoff_location_id,

    -- timestamps (standardized naming)
    cast(tpep_pickup_datetime as TIMESTAMP) as pickup_datetime,
    cast(tpep_dropoff_datetime as TIMESTAMP) as dropoff_datetime,

    -- trip info
    store_and_fwd_flag,
    cast(passenger_count as INT64) as passenger_count,
    cast(trip_distance as NUMERIC) as trip_distance,
    1 as trip_type, -- yellow taxis only be street-hail (trip_type=1)

    -- payment info
    cast(fare_amount as NUMERIC) as fare_amount,
    cast(extra as NUMERIC) as extra,
    cast(mta_tax as NUMERIC) as mta_tax,
    cast(tip_amount as NUMERIC) as tip_amount,
    cast(tolls_amount as NUMERIC) as tolls_amount,
    cast(improvement_surcharge as NUMERIC) as improvement_surcharge,
    0 as ehail_fee, -- yellow taxis do not have ehail fees
    cast(total_amount as NUMERIC) as total_amount,
    cast(payment_type as INT64) as payment_type

FROM {{ source('raw_data', 'yellow_tripdata') }}

-- Filter out records with null vendor_id (data quality requirement)
WHERE vendorid is not null

