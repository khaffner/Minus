# Build headers for posting to Home Assistant
$headers = @{
    "Authorization" = "Bearer $env:HATOKEN";
    "Content-Type"  = "application/json"
}

# Infinite loop
while ($true) {
    # Only run if OBD is connected
    if (Test-Path -Path "/dev/obd") {
        # Tell HA OBD is online
        Invoke-RestMethod -Uri "http://homeassistant.local:8123/api/states/sensor.OBD" -Method Post -Body @{"state" = "Connected" } -Headers $headers

        # Actually get the data from the car, store it as local csv file. https://github.com/khaffner/triplet-bmu
        python3 csvdump.py

        # Get the data, loop through the rows and post a sensor state for each data point
        Import-Csv *.csv -Header Name, Value | foreach -Parallel {
            Clear-Variable -Name body, name -ErrorAction SilentlyContinue
            $body = @{"state" = $PSItem.Value }
            $name = $PSItem.Name
            Write-Host "Posting $body to sensor $name"
            Invoke-RestMethod -Uri "http://homeassistant.local:8123/api/states/sensor.$name" -Method Post -Body $body -Headers $headers
        }
    }
    else {
        # Tell HA OBD is disconnected
        Invoke-RestMethod -Uri "http://homeassistant.local:8123/api/states/sensor.OBD" -Method Post -Body @{"state" = "Disconnected" } -Headers $headers
    }
    Start-Sleep -Seconds 8
}