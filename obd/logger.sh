while true; do
    # Delete all old csv files
    rm *.csv

    # Actually get the data from the car, gets saved as json
    python3 csvdump.py

    # Convert data to json to help Home Assistant parse it
    pwsh -Command '& {$data = New-Object -TypeName psobject ; Import-Csv *.csv -Header Name,Value | foreach {$data | Add-Member -NotePropertyName $PSItem.Name -NotePropertyValue $PSItem.Value} ; $data | ConvertTo-Json | Out-File -Path /logs/dump.json -Force}'
    sleep 50
done
