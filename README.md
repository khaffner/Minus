# Minus

![i-Miev](https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/2010_Mitsubishi_i-MiEV_%28GA_MY10%29_hatchback_%282015-11-11%29_01.jpg/1920px-2010_Mitsubishi_i-MiEV_%28GA_MY10%29_hatchback_%282015-11-11%29_01.jpg)
(Not our car, but one like this)

This repo contains code and config for the Raspberry Pi 4B in our Mitsubishi i-Miev named "Minus".

Mostly containerized, some parts run locally.

Most documentation is in a private google doc.
But long story short: Get OBD, GPS and bluetooth data, show them in Home Assistant on car radio display and sync them to a folder in Google Drive.

To upgrade and restart everything, run
```console
cd minus && git pull && docker-compose pull &&  docker-compose up -d --build --force-recreate --remove-orphans && cd ~
```