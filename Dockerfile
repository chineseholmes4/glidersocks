FROM traffmonetizer/cli:latest
COPY --from=nadoo/glider /app/glider /app/glider
COPY glider.conf /app/glider.conf
COPY --from=gogost/gost /bin/gost /app/gost
COPY gost.yml /app/gost.yml
COPY jp.rule /app/jp.rule
COPY run.sh /app/run.sh
RUN chmod +x /app/glider && \
    chmod +x /app/gost && \
    chmod +x /app/run.sh 
ENTRYPOINT /app/run.sh
