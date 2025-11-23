SELECT DISTINCT
    user_id,
    name AS user_name,
    job_title AS user_job,
    job_level AS user_job_level
FROM
    {{ ref('clean_user_job') }}
WHERE user_id IS NOT NULL
  AND name IS NOT NULL
