-- order_dim
    CREATE TABLE IF NOT EXISTS order_dim (
        order_pk VARCHAR(250) PRIMARY KEY,
        user_pk TEXT,
        merchant_pk TEXT,
        staff_pk TEXT,
        campaign_pk VARCHAR(250),
        order_transaction_date DATE,
        order_arrival_days INTEGER,
        order_delay_days INTEGER
    );
    INSERT INTO order_dim (
        order_pk,
        user_pk,
        merchant_pk,
        staff_pk,
        campaign_pk,
        order_transaction_date,
        order_arrival_days,
        order_delay_days
    )
    SELECT
        co.order_id,
        COALESCE(ud.user_pk, 0) AS user_pk,           -- fallback to Unknown
        COALESCE(md.merchant_pk, 0) AS merchant_pk,
        COALESCE(sd.staff_pk, 0) AS staff_pk,
        COALESCE(cd.campaign_pk, 0) AS campaign_pk,
        co.order_transaction_date,
        co.order_arrival_days,
        co.order_delay_days
    FROM clean_order co

    LEFT JOIN user_dim ud       ON co.user_pk = ud.user_pk
    LEFT JOIN merchant_dim md   ON co.merchant_pk = md.merchant_pk
    LEFT JOIN staff_dim sd      ON co.staff_pk = sd.staff_pk
    LEFT JOIN campaign_dim cd   ON co.campaign_pk = cd.campaign_pk

    WHERE NOT EXISTS (
        SELECT 1 FROM order_dim od
        WHERE od.order_pk = co.order_id
    );
    INSERT INTO order_dim (order_pk)
    VALUES (0);

-- line_fact
    CREATE TABLE IF NOT EXISTS line_fact (
        line_pk INTEGER PRIMARY KEY,
        order_pk VARCHAR(250) NOT NULL,
        product_pk TEXT,
        line_price NUMERIC,
        line_quantity INTEGER
    );
INSERT INTO line_fact (
    line_pk,
    order_pk,
    product_pk,
    line_price,
    line_quantity
)
SELECT
    lid.line_id,
    COALESCE(od.order_pk, 0) AS order_pk,
    COALESCE(pd.product_pk, 0) AS product_pk,
    lid.line_price,
    lid.line_quantity
FROM clean_line lid
LEFT JOIN order_dim od   ON lid.order_id = od.order_pk
LEFT JOIN product_dim pd ON lid.product_pk = pd.product_pk
WHERE NOT EXISTS (
    SELECT 1
    FROM line_fact lf
    WHERE lf.line_pk = lid.line_id
);
