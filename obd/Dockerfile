# This image needs both pwsh and python3 because some things are better done in pwsh (:
# At the time of writing, Powershell images do not support arm... but dotnet sdk does and has pwsh
FROM mcr.microsoft.com/dotnet/sdk:6.0

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

COPY logger.ps1 logger.ps1

ENTRYPOINT [ "pwsh", "logger.ps1" ]