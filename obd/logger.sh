#!/bin/bash

ODB="/dev/obd"
while true; do
    if [ -f $OBD ]; then
        # Delete all old csv files
        rm *.csv

        # Actually get the data from the car, gets saved as csv
        python3 csvdump.py

        # Run pwsh script that loops the csv and posts to HA
        pwsh -f HApost.ps1

    else
        echo "OBD disconnected"
    fi

    sleep 8
done
