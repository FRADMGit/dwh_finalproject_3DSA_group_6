SELECT DISTINCT
    a.line_id,
    a.order_id,
    a.product_id,
    a.product_name,
    b.line_quantity,
    b.line_price
FROM {{ ref('stg_line_item_data_products') }} a
JOIN {{ ref('stg_line_item_data_prices') }} b
ON a.line_id = b.line_id
ORDER BY a.line_id ASC
