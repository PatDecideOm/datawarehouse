{{ config(materialized='table') }}

with fact_orders as (

    select      customer.c_custkey,
                customer.c_name,
                orders.o_orderstatus,
                sum(orders.o_totalprice) as o_totalprice
    from        {{ source('staging','CUSTOMER') }} as customer,
                {{ source('staging','ORDERS')}} as orders
    where       customer.c_custkey = orders.o_custkey
    group by    customer.c_custkey,
                customer.c_name,
                orders.o_orderstatus
)

select * from fact_orders