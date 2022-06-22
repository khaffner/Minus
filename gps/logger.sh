# https://ozzmaker.com/gps-data-logger-using-berrygps/

gpspipe -r -l -o /gps/$(date +"%Y%m%d-%H-%M-%S").nmea
