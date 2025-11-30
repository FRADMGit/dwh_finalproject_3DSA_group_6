SELECT DISTINCT
    product_id,
    product_name,
    price AS product_price,
    CASE WHEN POSITION('toys' IN product_type) > 0 THEN 1 ELSE 0 END AS toys,
    CASE WHEN POSITION('entertainment' IN product_type) > 0 THEN 1 ELSE 0 END AS entertainment,
    CASE WHEN POSITION('breakfast' IN product_type) > 0 THEN 1 ELSE 0 END AS breakfast,
    CASE WHEN POSITION('lunch' IN product_type) > 0 THEN 1 ELSE 0 END AS lunch,
    CASE WHEN POSITION('dinner' IN product_type) > 0 THEN 1 ELSE 0 END AS dinner,
    CASE WHEN POSITION('accessories' IN product_type) > 0 THEN 1 ELSE 0 END AS accessories,
    CASE WHEN POSITION('kitchenware' IN product_type) > 0 THEN 1 ELSE 0 END AS kitchenware,
    CASE WHEN POSITION('grocery' IN product_type) > 0 THEN 1 ELSE 0 END AS grocery,
    CASE WHEN POSITION('apparel' IN product_type) > 0 THEN 1 ELSE 0 END AS apparel,
    CASE WHEN POSITION('furniture' IN product_type) > 0 THEN 1 ELSE 0 END AS furniture,
    CASE WHEN POSITION('health' IN product_type) > 0 THEN 1 ELSE 0 END AS health,
    CASE WHEN POSITION('hygiene' IN product_type) > 0 THEN 1 ELSE 0 END AS hygiene,
    CASE WHEN POSITION('stationary' IN product_type) > 0 THEN 1 ELSE 0 END AS stationary,
    CASE WHEN POSITION('tools' IN product_type) > 0 THEN 1 ELSE 0 END AS tools,
    CASE WHEN POSITION('jewelry' IN product_type) > 0 THEN 1 ELSE 0 END AS jewelry,
    CASE WHEN POSITION('technology' IN product_type) > 0 THEN 1 ELSE 0 END AS technology,
    CASE WHEN POSITION('electronics' IN product_type) > 0 THEN 1 ELSE 0 END AS electronics,
    CASE WHEN POSITION('sports' IN product_type) > 0 THEN 1 ELSE 0 END AS sports,
    CASE WHEN POSITION('cosmetic' IN product_type) > 0 THEN 1 ELSE 0 END AS cosmetic,
    CASE WHEN POSITION('music' IN product_type) > 0 THEN 1 ELSE 0 END AS music,
    CASE WHEN POSITION('cleaning' IN product_type) > 0 THEN 1 ELSE 0 END AS cleaning,
    CASE WHEN POSITION('appliances' IN product_type) > 0 THEN 1 ELSE 0 END AS appliances,
    CASE WHEN POSITION('others' IN product_type) > 0 THEN 1 ELSE 0 END AS others
FROM {{ ref('clean_product_list') }}
WHERE product_id IS NOT NULL
  AND product_name IS NOT NULL
  AND price IS NOT NULL;
