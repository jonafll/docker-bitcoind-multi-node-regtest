FROM debian:buster-slim as builder
RUN apt-get update && apt-get install wget -y
WORKDIR /tmp
ARG VERSION="22.0"
RUN wget -O bitcoin.tar.gz "https://bitcoincore.org/bin/bitcoin-core-${VERSION}/bitcoin-${VERSION}-x86_64-linux-gnu.tar.gz" \
    && mkdir bin \
    && tar -xzvf bitcoin.tar.gz -C /tmp/bin --strip-components=2 "bitcoin-${VERSION}/bin/bitcoin-cli" "bitcoin-${VERSION}/bin/bitcoind" "bitcoin-${VERSION}/bin/bitcoin-wallet"

FROM debian:buster-slim
COPY --from=builder "/tmp/bin" /usr/local/bin
RUN groupadd -f -g 1000 bitcoin
RUN useradd -r -u 1000 -g bitcoin -s /bin/bash bitcoin
WORKDIR /home/bitcoin
RUN mkdir .bitcoin
COPY bitcoin.conf .bitcoin
COPY mine.sh /usr/local/bin
RUN chmod +x /usr/local/bin/mine.sh
COPY .bashrc .
RUN chown -R bitcoin:bitcoin /home/bitcoin
EXPOSE 18443 18444 28334 28335
USER bitcoin
