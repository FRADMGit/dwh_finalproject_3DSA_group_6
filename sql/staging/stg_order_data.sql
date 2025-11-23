SELECT DISTINCT
    order_id,
    user_id,
    REGEXP_REPLACE("estimated arrival", '[^0-9\.]', '', 'g') AS order_arrival_days,
    transaction_date AS order_transaction_date
FROM
    {{ ref('clean_order_data') }}
WHERE order_id IS NOT NULL
    AND user_id IS NOT NULL
