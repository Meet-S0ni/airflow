#!/usr/bin/env bash
set -e

if ([ "$AIRFLOW__ROLE" = "standalone" ] || [ "$AIRFLOW__ROLE" = "webserver" ]) && [ -n "$AIRFLOW__ADMIN__USERNAME" ]; then
  echo "Creating Airflow admin user..."
  airflow users create \
    --username "$AIRFLOW__ADMIN__USERNAME" \
    --password "$AIRFLOW__ADMIN__PASSWORD" \
    --firstname Admin \
    --lastname User \
    --role Admin \
    --email admin@example.com
fi

exec "$@"
