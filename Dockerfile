FROM debian:buster-slim as builder

RUN apt-get update -y && apt-get install -y wget

WORKDIR /tmp

ARG VERSION="22.0"

RUN wget -O bitcoin.tar.gz "https://bitcoincore.org/bin/bitcoin-core-${VERSION}/bitcoin-${VERSION}-x86_64-linux-gnu.tar.gz" \
    && mkdir bin \
    && tar -xzvf bitcoin.tar.gz -C /tmp/bin --strip-components=2 "bitcoin-${VERSION}/bin/bitcoin-cli" "bitcoin-${VERSION}/bin/bitcoind" "bitcoin-${VERSION}/bin/bitcoin-wallet"

RUN wget -O https://raw.githubusercontent.com/bitcoin/bitcoin/master/contrib/bitcoin-cli.bash-completion \
    && mkdir /etc/bash_completion.d \
    && mv bitcoin-cli.bash-completion /etc/bash_completion.d/ \
    && wget -O https://raw.githubusercontent.com/scop/bash-completion/master/bash_completion \
    && mv bash_completion /usr/share/bash-completion/

FROM debian:buster-slim

COPY --from=builder "/tmp/bin" /usr/local/bin/
COPY --from=builder "/tmp/bitcoin-cli.bash-completion" /etc/bash_completion.d/
COPY --from=builder "/tmp/bash_completion" /usr/share/bash-completion/

WORKDIR /home/bitcoin

RUN groupadd -f -g 1000 bitcoin && useradd -r -u 1000 -g bitcoin -s /bin/bash bitcoin && mkdir .bitcoin

COPY bitcoin.conf .bitcoin/
COPY mine.sh /usr/local/bin/
COPY bashrc .bashrc

RUN chmod +x /usr/local/bin/mine.sh && chown -R bitcoin:bitcoin /home/bitcoin

EXPOSE 18443 18444 28334 28335

USER bitcoin
