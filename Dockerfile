FROM debian:bullseye-slim as builder

RUN apt-get update -y && apt-get install -y curl

WORKDIR /tmp

ARG VERSION="24.0.1"

RUN curl -SLO "https://bitcoincore.org/bin/bitcoin-core-${VERSION}/bitcoin-${VERSION}-x86_64-linux-gnu.tar.gz" \
    && mkdir bin \
    && tar -xzf *.tar.gz -C /tmp/bin --strip-components=2 "bitcoin-${VERSION}/bin/bitcoin-cli" "bitcoin-${VERSION}/bin/bitcoind" "bitcoin-${VERSION}/bin/bitcoin-wallet"
RUN curl -SLO https://raw.githubusercontent.com/bitcoin/bitcoin/master/contrib/completions/bash/bitcoin-cli.bash-completion
RUN curl -SLO https://raw.githubusercontent.com/scop/bash-completion/master/bash_completion

FROM debian:bullseye-slim

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
