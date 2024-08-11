LOAD 'pgcapture';
TRUNCATE pgcapture.ddl_logs;

-- test multi-query statements mixing DDL / DML
\o /dev/null
-- older version of psql don't emit all the resultsets in multi-query
SELECT 1\; CREATE TABLE multi(id integer)\; INSERT INTO multi SELECT 1;
\o

-- test multi-query statements mixing DDL
DROP TABLE multi\; CREATE TABLE multi(val text);

-- Check the results
SELECT query, unnest(tags) FROM pgcapture.ddl_logs ORDER BY id;
