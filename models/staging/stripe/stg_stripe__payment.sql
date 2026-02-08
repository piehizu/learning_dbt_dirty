with 

source as (

    select * from {{ source('stripe', 'payment') }}

),

renamed as (

    select
        id AS payment_id,
        orderid AS order_id,
        paymentmethod AS payment_method,
        status as payment_status,
        amount / 100 amount,
        created as created_at,
        

    from source

)

select * from renamed