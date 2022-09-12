FROM debian:bullseye-slim

# Install required software
RUN apt-get update && apt-get install gpsd-clients -y && rm -rf /var/lib/apt/lists/*

# TODO https://forums.balena.io/t/gpsd-service-fails-to-start/9587/13

# Copy script
COPY logger.sh /app/logger.sh

ENTRYPOINT [ "/bin/sh", "/app/logger.sh" ]