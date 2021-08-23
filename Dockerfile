FROM debian:buster-slim as builder
RUN apt-get update && apt-get install wget -y
WORKDIR /tmp
ARG VERSION="0.21.1"
RUN wget -O bitcoin.tar.gz "https://bitcoincore.org/bin/bitcoin-core-${VERSION}/bitcoin-${VERSION}-x86_64-linux-gnu.tar.gz" \
    && mkdir bin \
	&& tar -xzvf bitcoin.tar.gz -C /tmp/bin --strip-components=2 "bitcoin-${VERSION}/bin/bitcoin-cli" "bitcoin-${VERSION}/bin/bitcoind" "bitcoin-${VERSION}/bin/bitcoin-wallet"

FROM debian:buster-slim
COPY --from=builder "/tmp/bin" /usr/local/bin
WORKDIR /root
RUN mkdir .bitcoin
COPY bitcoin.conf .bitcoin
EXPOSE 8332 18444