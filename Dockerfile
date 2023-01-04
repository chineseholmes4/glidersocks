FROM traffmonetizer/cli:latest
COPY --from=nadoo/glider /app/glider /app/glider
COPY glider.conf /app/glider.conf
COPY run.sh /app/run.sh
RUN chmod +x /app/glider && \
    chmod +x /app/run.sh 
ENTRYPOINT /app/run.sh
