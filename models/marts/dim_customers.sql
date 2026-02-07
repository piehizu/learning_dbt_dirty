--{{ config(materialized='table') }}


with customers as (

    select *
    from {{ ref('stg_jaffle_shop__customers') }}
),
/* {#
orders as (
-- if you have the ref ANYWHERE in the code the graph link
    select *
    from {{ ref('stg_jaffle_shop__orders') }}
),
#}
*/

payments as (
    select *
    from {{ ref('fct_orders') }}
),

customer_payments as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders,
        SUM(amount) as lifetime_value

    from payments

    group by 1

),

/*
customer_orders as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders

    from orders

    group by 1

),
*/

final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_payments.first_order_date,
        customer_payments.most_recent_order_date,
        coalesce(customer_payments.number_of_orders, 0) as number_of_orders,
        lifetime_value

    from customers

    left join customer_payments using (customer_id)
   
)

select * from final