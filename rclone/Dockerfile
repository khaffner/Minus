FROM rclone/rclone:1.58.1

# Copy script 
COPY sync.sh /app/sync.sh

ENTRYPOINT [ "/bin/sh", "/app/sync.sh" ]