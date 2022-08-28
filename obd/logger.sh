while true; do
    # Delete all old csv files
    rm *.csv

    # Actually get the data from the car, gets saved as json
    python3 csvdump.py

    # Convert data to json to help Home Assistant parse it
    pwsh -Command "& {Import-Csv *.csv -Header Name,Value | ConvertTo-Json | Out-File /logs/dump.json} -Force"
    sleep 50
done
