WITH ranked_users AS (
    SELECT
        ud.user_id,
        ud.user_name,
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
            PARTITION BY ud.user_id
            ORDER BY ud.user_creation_datetime DESC
        ) AS rn
    FROM {{ ref('stg_user_data') }} AS ud
    JOIN {{ ref('stg_user_credit_card') }} AS cc 
        ON ud.user_id = cc.user_id
    JOIN {{ ref('stg_user_job') }} AS job 
        ON ud.user_id = job.user_id
    WHERE ud.user_id IS NOT NULL
      AND ud.user_name IS NOT NULL
)
SELECT
    user_id,
    user_name,
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
WHERE rn = 1;
