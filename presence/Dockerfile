# https://github.com/gpiozero/gpiozero/issues/891
FROM ubuntu:18.04

RUN apt-get update && apt-get install -y libsystemd-dev python3.5 python3-dev python3-pip
RUN pip3 install gpiozero

COPY logger.py /app/logger.py

ENTRYPOINT [ "python3", "/app/logger.py" ]