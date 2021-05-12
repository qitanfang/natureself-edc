#!/bin/bash

set -e

run_nginx() {
    exec nginx -g "daemon off;"
}

run_django() {
    python3 manage.py migrate
    exec gunicorn \
        --bind=0.0.0.0:8000 \
        --workers=4 \
        --worker-class=gevent \
        --worker-connections=1000 \
        --name="nsapp" \
        nsproject.wsgi
}

run_celery_worker() {
    exec celery -A nsproject worker -l info
}

run_celery_beat() {
    exec celery -A nsproject beat -l info
}

help() {
    echo "Usage:"
    echo "    docker run ... nginx          # start nginx"
    echo "    docker run ... django         # start django"
    echo "    docker run ... celery-worker  # start celery worker"
}

if test -z "$1"; then
    help
    exit 0
fi

case "$1" in
    nginx)
        run_nginx
        ;;
    django)
        run_django
        ;;
    celery-worker)
        run_celery_worker
        ;;
    celery-beat)
        run_celery_beat
        ;;
    *)
        exec "$@"
        ;;
esac
