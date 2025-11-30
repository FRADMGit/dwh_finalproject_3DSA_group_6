SELECT
    merchant_id,
    merchant_creation_datetime,
    merchant_name,
    merchant_street,
    merchant_state,
    merchant_city,
    merchant_country,
    merchant_contact_number
FROM (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY merchant_id, merchant_name
            ORDER BY merchant_creation_datetime DESC NULLS LAST
        ) AS rn
    FROM {{ ref("stg_merchant_data") }}
)
WHERE rn = 1
