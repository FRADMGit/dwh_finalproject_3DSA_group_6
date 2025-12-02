-- CAMPAIGN DIM
  DROP TABLE IF EXISTS campaign_dim CASCADE;
  CREATE TABLE campaign_dim AS
  SELECT DISTINCT * FROM clean_campaign_data;
-- LINE FACT
  DROP TABLE IF EXISTS line_fact CASCADE;
  CREATE TABLE line_fact AS
  SELECT DISTINCT
      a.line_id,
      a.order_id,
      a.product_id,
      a.product_name,
      b.line_quantity,
      b.line_price
  FROM clean_line_item_data_products a
  JOIN clean_line_item_data_prices b
  ON a.line_id = b.line_id
  ORDER BY a.line_id ASC;
-- MERCHANT DIM
  DROP TABLE IF EXISTS merchant_dim CASCADE;
  CREATE TABLE merchant_dim AS
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
      FROM clean_merchant_data
  )
  WHERE rn = 1;
-- ORDER DIM
  DROP TABLE IF EXISTS order_dim CASCADE;
  CREATE TABLE order_dim AS
  WITH affiliations AS (
      SELECT
          a.order_id,
          b."user_id",
          a.merchant_id,
          a.staff_id,
          CASE WHEN d.campaign_availed = 1 THEN d.campaign_id ELSE NULL END AS campaign_id,
          b.order_transaction_date,
          b.order_arrival_days
      FROM clean_order_with_merchant_data a
      JOIN clean_order_data b ON a.order_id = b.order_id
      JOIN clean_user_data c ON b."user_id" = c."user_id"
      JOIN clean_transactional_campaign_data d ON b.order_id = d.order_id
  ),
  correct_user AS (
      SELECT DISTINCT
          order_id,
          "user_id",
          "user_name"
      FROM (
          SELECT
              o.order_id,
              u."user_id",
              u."user_name",
              u.user_creation_datetime,
              o.order_transaction_date,
              ROW_NUMBER() OVER (
                  PARTITION BY o.order_id
                  ORDER BY u.user_creation_datetime DESC
              ) AS rn
          FROM clean_order_data o
          JOIN clean_user_data u
              ON o."user_id" = u."user_id"
              AND u.user_creation_datetime <= o.order_transaction_date
      ) x
      WHERE rn = 1
  ),
  correct_merchant AS (
      SELECT DISTINCT
          order_id,
          merchant_id,
          merchant_name
      FROM (
          SELECT
              a.order_id,
              m.merchant_id,
              m.merchant_name,
              m.merchant_creation_datetime,
              a.order_transaction_date,
              ROW_NUMBER() OVER (
                  PARTITION BY a.order_id
                  ORDER BY m.merchant_creation_datetime DESC
              ) AS rn
          FROM affiliations a
          JOIN clean_merchant_data m
              ON a.merchant_id = m.merchant_id
              AND m.merchant_creation_datetime <= a.order_transaction_date
      ) x
      WHERE rn = 1
  ),
  correct_staff AS (
      SELECT DISTINCT
          order_id,
          staff_id,
          staff_name
      FROM (
          SELECT
              a.order_id,
              s.staff_id,
              s.staff_name,
              s.staff_creation_datetime,
              a.order_transaction_date,
              ROW_NUMBER() OVER (
                  PARTITION BY a.order_id
                  ORDER BY s.staff_creation_datetime DESC
              ) AS rn
          FROM affiliations a
          JOIN clean_staff_data s
              ON a.staff_id = s.staff_id
              AND s.staff_creation_datetime <= a.order_transaction_date
      ) x
      WHERE rn = 1
  )
  SELECT DISTINCT
      a.order_id,
      u."user_id",
      u."user_name",
      m.merchant_id,
      m.merchant_name,
      s.staff_id,
      s.staff_name,
      a.campaign_id,
      a.order_transaction_date,
      a.order_arrival_days,
      d.order_delay_days
  FROM affiliations a
  JOIN correct_user u ON a.order_id = u.order_id
  JOIN correct_merchant m ON a.order_id = m.order_id
  JOIN correct_staff s ON a.order_id = s.order_id
  JOIN clean_order_delays d ON a.order_id = d.order_id;
-- PRODUCT DIM
  DROP TABLE IF EXISTS product_dim CASCADE;
  CREATE TABLE product_dim AS
  SELECT DISTINCT * FROM clean_product_list;
-- STAFF DIM
  DROP TABLE IF EXISTS staff_dim CASCADE;
  CREATE TABLE staff_dim AS
  SELECT DISTINCT * FROM clean_staff_data;
-- USER DIM
  DROP TABLE IF EXISTS user_dim CASCADE;
  CREATE TABLE user_dim AS
  WITH ranked_users AS (
      SELECT
          ud."user_id",
          ud."user_name",
          ud.user_creation_datetime,
          ud.user_street,
          ud.user_state,
          ud.user_city,
          ud.user_country,
          ud.user_birth_datetime,
          ud.user_gender,
          ud.user_device_address,
          ud.user_type,
          cc.name AS credit_card_holder_name,
          cc.credit_card_number,
          cc.issuing_bank,
          job.user_job,
          job.user_job_level,
          ROW_NUMBER() OVER (
              PARTITION BY ud."user_id"
              ORDER BY ud.user_creation_datetime DESC
          ) AS rn
      FROM clean_user_data AS ud
      JOIN clean_user_credit_card AS cc 
          ON ud."user_id" = cc."user_id"
      JOIN clean_user_job AS job 
          ON ud."user_id" = job."user_id"
      WHERE ud."user_id" IS NOT NULL
        AND ud."user_name" IS NOT NULL
  )
  SELECT
      "user_id",
      "user_name",
      user_creation_datetime,
      user_street,
      user_state,
      user_city,
      user_country,
      user_birth_datetime,
      user_gender,
      user_device_address,
      user_type,
      credit_card_holder_name,
      credit_card_number,
      issuing_bank,
      user_job,
      user_job_level
  FROM ranked_users
  WHERE rn = 1
