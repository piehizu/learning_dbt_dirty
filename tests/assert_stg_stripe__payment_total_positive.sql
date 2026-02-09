-- Refunds have a negative amount, so the total amount should always be >= 0.
-- Therefore return records where this isn't true to make the test fail.

SELECT 

    order_id,
    sum(amount) as total_amount

FROM {{ ref('stg_stripe__paymentdata') }}
group by order_id
HAVING sum(amount) < 0