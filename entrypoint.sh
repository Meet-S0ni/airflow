#!/usr/bin/env bash
set -e
if [ "$AIRFLOW_ROLE" = "webserver" ] && [ -n "$AIRFLOW_ADMIN_USER" ]; then
  echo "Creating Airflow admin user..."
  airflow users create \
    --username "$AIRFLOW_ADMIN_USER" \
    --password "$AIRFLOW_ADMIN_PASSWORD" \
    --firstname Admin \
    --lastname User \
    --role Admin \
    --email admin@example.com
fi
exec "$@"
