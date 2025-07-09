USE DATABASE alpha_db;
USE SCHEMA information_schema;

SELECT * 
FROM TABLE(task_history())
WHERE name = 'TASK_STREAM_HAS_DATA'
ORDER BY scheduled_time DESC
LIMIT 5;
