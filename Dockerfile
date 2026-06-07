FROM alpine:latest
RUN apk add --no-cache curl unzip
WORKDIR /app
RUN curl -L -o /tmp/xray.zip "https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip" && \
    unzip /tmp/xray.zip -d /app && \
    chmod +x /app/xray && \
    rm -rf /tmp/xray.zip
RUN echo '{\
  "inbounds": [{\
    "port": 10000,\
    "protocol": "vless",\
    "settings": {\
      "clients": [{"id": "e3b4a2c8-8f65-4f71-bc01-9a4d8c7e2b3a", "level": 0}],\
      "decryption": "none"\
    },\
    "streamSettings": {\
      "network": "ws",\
      "wsSettings": {"path": "/"}\
    }\
  }],\
  "outbounds": [{"protocol": "freedom"}]\
}' > /app/config.json
CMD ["/app/xray", "-config", "/app/config.json"]

