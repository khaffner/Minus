# This image needs both pwsh and python3 because some things are better done in pwsh (:
FROM mcr.microsoft.com/powershell:lts-7.2-debian-bullseye-slim

SHELL ["/bin/sh", "-c"]

RUN apt-get update
RUN apt-get install python3 python3-pip -y
RUN pip3 install pyserial
RUN mkdir /logs
WORKDIR /app

ADD https://github.com/khaffner/triplet-bmu/archive/master.tar.gz triplet-bmu.tar.gz
RUN tar xvfz triplet-bmu.tar.gz
RUN rm triplet-bmu.tar.gz

WORKDIR /app/triplet-bmu-master

COPY logger.sh logger.sh
COPY HApost.ps1 HApost.ps1

ENTRYPOINT [ "pwsh", "logger.ps1" ]