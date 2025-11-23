SELECT DISTINCT
    campaign_id,
    order_id,
    transaction_date AS order_transaction_date,
    REGEXP_REPLACE("estimated arrival", '[^0-9\.]', '', 'g') AS order_arrival_days,
    availed AS campaign_availed
FROM
    {{ ref('clean_transactional_campaign_data') }}
WHERE campaign_id IS NOT NULL
  AND order_id IS NOT NULL
