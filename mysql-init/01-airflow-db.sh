#!/bin/bash
# Creates the Airflow metadata database and grants the app user access.
# Runs once on first container start via docker-entrypoint-initdb.d.
# Using a shell script (vs .sql) so we can reference $MYSQL_USER at runtime.
set -e

mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" <<-EOSQL
    CREATE DATABASE IF NOT EXISTS airflow_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
    GRANT ALL PRIVILEGES ON airflow_db.* TO '${MYSQL_USER}'@'%';
    FLUSH PRIVILEGES;
EOSQL
