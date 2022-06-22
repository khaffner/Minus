# Sync is one way, so deletions must happen on source(pi). Hence the cleanup below before the sync

echo "Deleting log files older than 90 days"
find /logs/ -type f -mtime +90 -print | xargs rm -rf # https://stackoverflow.com/a/26870816

while true; do
    if ping -c 4 8.8.8.8 &>/dev/null; then
        # Only attempt sync if online
        rclone sync /logs googledrive: --verbose
    else
        echo "Offline, trying again in a minute"
    fi
    sleep 1m # 1 minute interval, regardless if offline or online
done
