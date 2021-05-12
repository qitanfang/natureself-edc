FROM docker.ns-inc.cn/natureself/images/py39-build as builder

ARG PRODUCT
ENV PRODUCT=${PRODUCT}

ADD . $PROJECT_ROOT/

RUN set -e \
        && pip3 install --no-cache-dir -r requirements-${PRODUCT}.txt \
        && mkdir -pv $PROJECT_ROOT/html \
        && cp nsproject/settings_local.example.py nsproject/settings_local.py \
        && cp nsproject/config.example.yaml nsproject/config.yaml \
        && DJANGO_DEBUG=false python3 manage.py collectstatic --noinput

# -------- 8< --------

FROM docker.ns-inc.cn/natureself/images/py39-app
COPY --from=builder /opt/venv           /opt/venv
COPY --from=builder $PROJECT_ROOT/html  $PROJECT_ROOT/html

ARG PRODUCT
ENV PRODUCT=${PRODUCT}

ADD . $PROJECT_ROOT/

RUN set -e \
        && apt-get update \
        && apt-get install -y --no-install-recommends nginx \
        && rm -rf /var/lib/apt/lists/* \
        && sed -ri '/sites-enabled/d' /etc/nginx/nginx.conf

ADD entrypoint.sh /entrypoint.sh
ADD nginx.conf /etc/nginx/conf.d/default.conf

ARG RELEASE
ENV SENTRY_RELEASE $RELEASE

ENTRYPOINT ["/entrypoint.sh"]
