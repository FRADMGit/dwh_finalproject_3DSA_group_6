SELECT DISTINCT
    "Unnamed: 0" AS line_id,
    order_id,
    product_name,
    product_id
FROM
    {{ ref('clean_line_item_data_products') }}
WHERE "Unnamed: 0" IS NOT NULL
    AND order_id IS NOT NULL
ORDER BY "Unnamed: 0" ASC
