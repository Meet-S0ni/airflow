#!/bin/bash
set -e

# Initialize the Airflow metadata database
airflow db init

# Create a default admin user if it doesn't exist
airflow users list | grep -q "admin" || airflow users create \
    --username admin \
    --firstname Admin \
    --lastname User \
    --role Admin \
    --email admin@example.com \
    --password admin

# Start the Airflow service specified in the command
case "$1" in
  webserver)
    exec airflow webserver
    ;;
  scheduler)
    exec airflow scheduler
    ;;
  worker)
    exec airflow celery worker
    ;;
  flower)
    exec airflow celery flower
    ;;
  *)
    exec "$@"
    ;;
esac
