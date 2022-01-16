ARG PG_VERSION=14.1

FROM alpine:3.15.0 AS base

LABEL author Wolfgang Walther
LABEL maintainer vlux@technowledgy.de
LABEL license MIT

WORKDIR /usr/src
SHELL ["/bin/sh", "-eux", "-c"]

COPY tools /usr/local/bin
COPY .yamllint.yaml /usr/local/share/yamllint/config.yaml

ARG KUSTOMIZE_VERSION="v4.4.1"
ARG KUBEVAL_VERSION="v0.16.1"
ARG FLUX2_VERSION="v0.25.2"

RUN apk add \
        --no-cache \
        bash \
        the_silver_searcher \
        yamllint \
### build-deps
  ; apk add \
        --no-cache \
        --virtual build-deps \
        curl \
        tar \
### kustomize
  ; curl -sL https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz \
      | tar xz -C /usr/local/bin \
  ; chmod +x /usr/local/bin/kustomize \
### kubeval
  ; curl -sL https://github.com/instrumenta/kubeval/releases/download/${KUBEVAL_VERSION}/kubeval-linux-amd64.tar.gz \
      | tar xz -C /usr/local/bin \
  ; chmod +x /usr/local/bin/kubeval \
### flux2 crd schemas
  ; mkdir -p /usr/local/share/schemas/master-standalone-strict \
  ; curl -sL https://github.com/fluxcd/flux2/releases/download/${FLUX2_VERSION}/crd-schemas.tar.gz \
      | tar xz -C /usr/local/share/schemas/master-standalone-strict \
### cleanup
  ; apk del --no-cache build-deps

FROM base AS test

RUN apk add \
        --no-cache \
        ncurses \
        yarn \
  ; yarn global add \
         bats \
         bats-assert \
         bats-support

FROM base
