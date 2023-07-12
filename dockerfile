FROM python:2.7-alpine

COPY Pipfile /tmp/requirements.txt
RUN  sed -i '/packages/d' /tmp/requirements.txt && \
     sed -i 's/ =.*//g' /tmp/requirements.txt

RUN apk update && \
    apk add --no-cache \
        gcc \
        libffi-dev \
        libressl-dev \
        musl-dev && \
    pip install --no-cache-dir typing && \
    pip install --no-cache-dir -r /tmp/requirements.txt && \
    rm /tmp/requirements.txt && \
    apk del gcc

COPY docker-entrypoint.sh /entrypoint.sh

CMD ["/bin/sh", "/entrypoint.sh"]