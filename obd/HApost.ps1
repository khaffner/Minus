
$headers = @{
    "Authorization" = "Bearer $env:HATOKEN";
    "Content-Type"  = "application/json"
}
Import-Csv *.csv -Header Name, Value | foreach -Parallel {
    Clear-Variable -Name body, name -ErrorAction SilentlyContinue
    $body = @{"state" = $PSItem.Value }
    $name = $PSItem.Name
    Write-Host "Posting $body to sensor $name"
    Invoke-RestMethod -Uri "http://homeassistant.local:8123/api/states/sensor.$name" -Method Post -Body $body -Headers $headers
}