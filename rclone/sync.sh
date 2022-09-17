# Sync is one way, so deletions must happen on source(pi). Hence the cleanup below before the sync

echo "Deleting log files older than 180 days"
find /logs/ -type f -mtime +180 -print | xargs rm -rf # https://stackoverflow.com/a/26870816

while true; do
    if ping -c 4 8.8.8.8 &>/dev/null; then
        # Only attempt sync if online
        rclone sync /logs googledrive: --verbose
        status="Done syncing"
    else
        echo "Offline, trying again in a minute"
        status="Offline"
    fi

    # Send status to Home Assistant
    json=$(jq -c --null-input --arg status "$status" '{"state":$status}')
    curl -X POST \
        -H "Authorization: Bearer ${HATOKEN}" \
        -H "Content-Type: application/json" \
        http://homeassistant:8123/api/states/sensor.syncstatus \
        -d $json

    sleep 1m # 1 minute interval, regardless if offline or online

done
