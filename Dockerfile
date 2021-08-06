FROM debian:buster-slim


ARG GHCUP_BIN_DIR=/root/.ghcup/bin
# /root happens to be $HOME but we can't use the directly in an ARG
ARG GHCUP_DWN_URL=https://downloads.haskell.org/~ghcup/x86_64-linux-ghcup
ARG GHC_VERSION=8.10.2


ARG PATH
RUN test -n ${PATH}
ENV PATH=${PATH}:${GHCUP_BIN_DIR}
ENV LANG=C.UTF-8
ENV BOOTSTRAP_HASKELL_NONINTERACTIVE=1


RUN \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2


RUN \
  curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
  curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list
# MSSQL packages


RUN \
  apt-get update && \
  apt-get upgrade -y && \
  ACCEPT_EULA=Y apt-get install -y \
    default-libmysqlclient-dev \
    default-mysql-client \
    freetds-dev \
    g++ \
    gcc \
    git \
    libc-dev \
    libghc-pcre-light-dev \
    libghc-hsopenssl-dev \
    libgmp-dev \
    libgssapi-krb5-2 \
    libkrb5-dev \
    libpq-dev \
    locales \
    make \
    msodbcsql17 \
    mssql-tools \
    unixodbc-dev


RUN \
  locale-gen en_US.UTF-8


RUN \
  mkdir -p ${GHCUP_BIN_DIR}


RUN \
	curl -sSL ${GHCUP_DWN_URL} > ${GHCUP_BIN_DIR}/ghcup && \
	chmod +x ${GHCUP_BIN_DIR}/ghcup


RUN \
  ghcup upgrade && \
  ghcup install cabal && \
  ghcup install ghc ${GHC_VERSION} && \
  ghcup set ghc ${GHC_VERSION} && \
  ghcup install hls


RUN \
  cabal update && \
  cabal install hlint stylish-haskell fourmolu


# docker run --rm -it --name ghcup -v `pwd`:/workdir -w /workdir ghcup bash
