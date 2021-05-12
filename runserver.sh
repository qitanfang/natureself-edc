#!/bin/bash

case "$1" in
    zredc)
        PRODUCT=zredc ./manage.py runserver 0.0.0.0:8000
        ;;
    rfedc)
        PRODUCT=rfedc ./manage.py runserver 0.0.0.0:8000
        ;;
    *)
        echo "Usage:"
        echo "    $0 zredc  -- 启动中日 EDC"
        echo "    $0 rfedc  -- 启动 ResearchForce EDC"
        ;;
esac
