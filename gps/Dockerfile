FROM debian:bullseye-slim

# Install required software
RUN apt-get update && apt-get install gpsd gpsd-clients -y && rm -rf /var/lib/apt/lists/*

# Set config
COPY gpsd /etc/default/gpsd

# Copy script
COPY logger.sh /app/logger.sh

ENTRYPOINT [ "/bin/sh", "/app/logger.sh" ]