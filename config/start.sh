#!/bin/bash

cd /app

if [ $# -eq 0 ]; then
    # echo "Usage: start.sh [PROCESS_TYPE](server/beat/worker/flower)"
    echo "Usage: start.sh [PROCESS_TYPE](server)"
    exit 1
fi

PROCESS_TYPE=$1

if [ "$PROCESS_TYPE" = "server" ]; then
    if [ "$DJANGO_DEBUG" = "true" ]; then
        gunicorn \
            --reload \
            --bind 0.0.0.0:8000 \
            --workers 2 \
            --log-level DEBUG \
            --access-logfile "-" \
            --error-logfile "-" \
            cognito.wsgi
    else
        gunicorn \
            --bind 0.0.0.0:8000 \
            --workers 2 \
            --log-level DEBUG \
            --access-logfile "-" \
            --error-logfile "-" \
            cognito.wsgi
    fi
# elif [ "$PROCESS_TYPE" = "beat" ]; then
#     celery \
#         --app cognito.celery_app \
#         beat \
#         --loglevel INFO \
#         --scheduler django_celery_beat.schedulers:DatabaseScheduler
# elif [ "$PROCESS_TYPE" = "flower" ]; then
#     celery \
#         --app cognito.celery_app \
#         flower \
#         --basic_auth="${CELERY_FLOWER_USER}:${CELERY_FLOWER_PASSWORD}" \
#         --loglevel INFO
# elif [ "$PROCESS_TYPE" = "worker" ]; then
#     celery \
#         --app cognito.celery_app \
#         worker \
#         --loglevel INFO
fi