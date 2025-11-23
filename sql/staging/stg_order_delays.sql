SELECT DISTINCT
  order_id,
  "delay in days" AS order_delay_days
FROM {{ ref('clean_order_delays') }}
WHERE order_delay IS NOT NULL
  AND order_id IS NOT NULL
