while true; do
    if ping -c 4 8.8.8.8 &>/dev/null; then
        # Only attempt sync if online
        rclone sync /logs googledrive: --verbose
    else
        echo "Offline, trying again in a minute"
    fi
    sleep 1m # 1 minute interval, regardless if offline or online
done
