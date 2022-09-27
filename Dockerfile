FROM alpine AS builder

RUN apk -U --no-cache add git \
  && cd /tmp \
  && git clone --depth=1 https://github.com/mruettgers/modbus2mqtt

FROM python:3-alpine
MAINTAINER Michael Ruettgers <michael@ruettgers.eu>

COPY --from=builder /tmp/modbus2mqtt /opt/modbus2mqtt

RUN pip3 install paho-mqtt serial modbus_tk

WORKDIR "/opt/modbus2mqtt"

ENTRYPOINT [ "python3", "modbus2mqtt.py"]
