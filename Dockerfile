FROM nadoo/glider
ENV PORT 8888
ENV TZ=Asia/Shanghai
WORKDIR /app
CMD ["glider", "-listen=ws://:8888,vless://707f20ea-d4b8-4d1d-8e2e-2c86cb2ed97a@?fallback=127.0.0.1:80"]