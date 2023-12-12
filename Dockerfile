FROM alpine:3.19.0 AS base

LABEL org.opencontainers.image.authors Wolfgang Walther
LABEL org.opencontainers.image.source https://github.com/technowledgy/vlux
LABEL org.opencontainers.image.licences MIT

WORKDIR /usr/src
SHELL ["/bin/sh", "-eux", "-c"]

COPY tools /usr/local/bin
COPY .yamllint.yaml /usr/local/share/yamllint/config.yaml

# renovate: datasource=github-releases depName=kustomize lookupName=kubernetes-sigs/kustomize
ARG KUSTOMIZE_VERSION="v5.3.0"

# renovate: datasource=github-releases depName=kubeval lookupName=instrumenta/kubeval
ARG KUBEVAL_VERSION="v0.16.1"

# renovate: datasource=github-releases depName=flux2 lookupName=fluxcd/flux2
ARG FLUX2_VERSION="v2.2.0"

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
