SELECT DISTINCT
    "Unnamed: 0" AS line_id,
    order_id,
    product_name,
    product_id
FROM
    {{ ref('clean_line_item_data_products') }}
ORDER BY "Unnamed: 0" ASC
