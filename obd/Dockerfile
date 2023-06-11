# This image needs both pwsh and python3 because some things are better done in pwsh (:
# At the time of writing, Powershell images do not support arm... but dotnet sdk does and has pwsh
FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine

SHELL ["/bin/sh", "-c"]

RUN apk update update
RUN apk add --no-cache openjdk8

WORKDIR /app
ADD https://github.com/BITPlan/can4eve/raw/3a27a630f7b23d609ea92aa46ab006a58c08994c/obdii/release/can4eve.jar can4eve.jar
COPY logger.ps1 logger.ps1

#ENTRYPOINT [ "pwsh", "logger.ps1" ]