#!/bin/bash
set -e

# 1. Initialize Airflow DB if not already done
airflow db init

# 2. Create a default admin user if it doesn't exist
airflow users list | grep -q "admin" || airflow users create \
    --username admin \
    --firstname Admin \
    --lastname User \
    --role Admin \
    --email admin@example.com \
    --password admin

# 3. Start Supervisor to run multiple Airflow processes
exec /usr/bin/supervisord -c /etc/supervisord.conf
