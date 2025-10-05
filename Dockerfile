FROM earnfm/earnfm-client:latest AS source

FROM ubuntu:24.04 AS final

WORKDIR /app

ENV EARNFM_TOKEN=$TOKEN

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
       ca-certificates bash curl dos2unix iptables redsocks libc6 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=source /app/earnfm_example /app/earnfmCLI

COPY entrypoint.sh /app/entrypoint.sh

RUN dos2unix /app/entrypoint.sh

RUN chmod +x /app/entrypoint.sh /app/earnfmCLI

ENTRYPOINT ["/app/entrypoint.sh"]

CMD ["bash"]