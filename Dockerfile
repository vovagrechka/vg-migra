FROM python:3.9-alpine

COPY . /app
ENV PATH="${PATH}:/root/.local/bin"

RUN apk add --update --no-cache --upgrade postgresql-libs && \
    apk add --no-cache --virtual=build-dependencies build-base postgresql-dev && \
    apk add curl && \
    pip install --no-cache-dir packaging psycopg2-binary && \
    curl -sSL https://install.python-poetry.org | python3 - && \
    cd /app && poetry install && \
    apk del build-dependencies && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* 

CMD ["migra", "--help"]
