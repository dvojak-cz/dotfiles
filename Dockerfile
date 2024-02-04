FROM debian:12 AS base
WORKDIR /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y stow make && \
    apt-get -y clean && \
    apt-get -y autoclean && \
    rm -rf /var/lib/apt/lists/*

FROM base AS jan
RUN addgroup --gid 1000 jan
RUN adduser --gecos jan --uid 1000 --gid 1000 --disabled-password jan
USER jan
WORKDIR /home/jan

FROM jan
RUN mkdir .config
CMD ['/usr/bin/bash']

