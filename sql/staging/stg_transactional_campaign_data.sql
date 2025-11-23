SELECT DISTINCT
    campaign_id,
    order_id,
    availed AS campaign_availed
FROM
    {{ ref('clean_transactional_campaign_data') }}
WHERE campaign_id IS NOT NULL
  AND order_id IS NOT NULL
