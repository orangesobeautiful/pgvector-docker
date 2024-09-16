ARG POSTGRESQL_VERSION=17rc1-alpine3.20
ARG PG_VECTOR_VERSION=0.7.4

FROM postgres:${POSTGRESQL_VERSION} AS builder
ARG PG_VECTOR_VERSION

RUN apk add --no-cache --virtual build-dependencies git build-base clang15 llvm15 && \
    git clone --branch v${PG_VECTOR_VERSION} https://github.com/pgvector/pgvector.git \
    && cd pgvector \
    && make clean \
    && make OPTFLAGS="" \
    && make install \
    && mkdir -p /usr/share/doc/pgvector \
    && cp LICENSE README.md /usr/share/doc/pgvector \
    && rm -rf /pgvector \
    && apk del build-dependencies
