## Builder
FROM ubuntu:18.10 AS builder

ENV RAUC_VERSION v1.1

RUN apt-get -y update && \
    apt-get -y install git automake libtool libdbus-1-dev libglib2.0-dev libcurl3-dev libssl-dev libjson-glib-dev

# Build RAUC
RUN git clone https://github.com/rauc/rauc.git /rauc
WORKDIR /rauc/
RUN git checkout "${RAUC_VERSION}" && \
    ./autogen.sh && \
    ./configure && \
    make install

## Final stage
FROM ubuntu:18.10

RUN mkdir -p /data/input && \
    mkdir -p /data/output && \
    mkdir -p /data/keys && \
    apt-get -y update && \
    apt-get -y install libjson-glib-dev squashfs-tools curl && \
    rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/bin/rauc /usr/local/bin/rauc

VOLUME [ "/data" ]

ENTRYPOINT ["rauc"]
