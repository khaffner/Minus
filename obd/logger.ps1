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
        Invoke-RestMethod -Uri "http://localhost:8123/api/states/sensor.OBD" -Method Post -Body @{"state" = "Connected" } -Headers $headers

        try {
            # Actually get the data from the car, store it as local csv file. https://github.com/khaffner/triplet-bmu
            python3 csvdump.py

            # Get the data, loop through the rows and post a sensor state for each data point
            Import-Csv *.csv -Header Name, Value | foreach -Parallel {
                Clear-Variable -Name body, name, value -ErrorAction SilentlyContinue
                
                # Some cleanup, as only a-z0-9_ is allowed
                $Value = $PSItem.Value
                $Value = $Value.ToLower() # Must be lowercase
                $Value = $Value.Replace(' ', '_') # Spaces are not allowed, best replaced by underscore
                $Value = $Value.Replace('/', 'per') # Slash is not allowed, in this data only means "per" as in kwh per 100km
                $Value = $Value.Replace('%', 'percent') # Percantage symbol not allowed, in this data only means percent.

                $body = @{"state" = $Value } | ConvertTo-Json -Compress
                $name = $PSItem.Name
                Write-Host "Posting $body to sensor $name"
                Invoke-RestMethod -Uri "http://localhost:8123/api/states/sensor.$name" -Method Post -Body $body -Headers $headers
            }
        }
        catch {
            Invoke-RestMethod -Uri "http://localhost:8123/api/states/sensor.OBD" -Method Post -Body (@{"state" = "Error" } | ConvertTo-Json -Compress) -Headers $headers
        }
    }
    else {
        # Tell HA OBD is disconnected
        Invoke-RestMethod -Uri "http://localhost:8123/api/states/sensor.OBD" -Method Post -Body (@{"state" = "Disconnected" } | ConvertTo-Json -Compress) -Headers $headers
    }
    Start-Sleep -Seconds 8
}