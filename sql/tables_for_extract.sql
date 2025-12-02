DROP TABLE IF EXISTS user_job CASCADE;
CREATE TABLE user_job (
  "index" NUMERIC,
  "user_id" VARCHAR(250),
  name VARCHAR(250),
  job_title VARCHAR(250),
  job_level VARCHAR(250) 
);

DROP TABLE IF EXISTS user_data CASCADE;
CREATE TABLE user_data (
  "user_id" VARCHAR(250),
  creation_date TIMESTAMP,
  name VARCHAR(250),
  street VARCHAR(250),
  state VARCHAR(250),
  city VARCHAR(250),
  country VARCHAR(250),
  birthdate TIMESTAMP,
  gender VARCHAR(250),
  device_address VARCHAR(250),
  user_type VARCHAR(250)
);

DROP TABLE IF EXISTS order_data CASCADE;
CREATE TABLE order_data (
  order_id VARCHAR(250),
  "user_id" VARCHAR(250),
  "estimated arrival" VARCHAR(250),
  transaction_date DATE,
  "index" NUMERIC
);

DROP TABLE IF EXISTS staff_data CASCADE;
CREATE TABLE staff_data (
  "index" NUMERIC,
  staff_id VARCHAR(250),
  name VARCHAR(250),
  job_level VARCHAR(250),
  street VARCHAR(250),
  state VARCHAR(250),
  city VARCHAR(250),
  country VARCHAR(250),
  contact_number VARCHAR(250),
  creation_date TIMESTAMP
);

DROP TABLE IF EXISTS order_delays CASCADE;
CREATE TABLE order_delays (
  "index" NUMERIC,
  order_id VARCHAR(250),
  "delay in days" VARCHAR(250)
);

DROP TABLE IF EXISTS product_list CASCADE;
CREATE TABLE product_list (
  "index" NUMERIC,
  product_id VARCHAR(250),
  product_name VARCHAR(250),
  product_type VARCHAR(250),
  price NUMERIC
);

DROP TABLE IF EXISTS campaign_data CASCADE;
CREATE TABLE campaign_data (
  "index" NUMERIC,
  campaign_id VARCHAR(250),
  campaign_name VARCHAR(250),
  campaign_description VARCHAR(250),
  discount VARCHAR(250)
);

DROP TABLE IF EXISTS merchant_data CASCADE;
CREATE TABLE merchant_data (
  "index" NUMERIC,
  merchant_id VARCHAR(250),
  creation_date TIMESTAMP,
  name VARCHAR(250),
  street VARCHAR(250),
  state VARCHAR(250),
  city VARCHAR(250),
  country VARCHAR(250),
  contact_number VARCHAR(250)
);

DROP TABLE IF EXISTS user_credit_card CASCADE;
CREATE TABLE user_credit_card (
  "user_id" VARCHAR(250),
  name VARCHAR(250),
  credit_card_number VARCHAR(250),
  issuing_bank VARCHAR(250)
);

DROP TABLE IF EXISTS line_item_data_prices CASCADE;
CREATE TABLE line_item_data_prices (
  line_id VARCHAR(250),
  order_id VARCHAR(250),
  price NUMERIC,
  quantity VARCHAR(250)
);

DROP TABLE IF EXISTS line_item_data_products CASCADE;
CREATE TABLE line_item_data_products (
  line_id VARCHAR(250),
  order_id VARCHAR(250),
  product_id VARCHAR(250),
  product_name VARCHAR(250)
);

DROP TABLE IF EXISTS order_with_merchant_data CASCADE;
CREATE TABLE order_with_merchant_data (
  order_id VARCHAR(250),
  merchant_id VARCHAR(250),
  staff_id VARCHAR(250),
  "index" NUMERIC
);

DROP TABLE IF EXISTS transactional_campaign_data CASCADE;
CREATE TABLE transactional_campaign_data (
  "index" NUMERIC,
  transaction_date DATE,
  campaign_id VARCHAR(250),
  order_id VARCHAR(250),
  "estimated arrival" VARCHAR(250),
  availed NUMERIC
);
