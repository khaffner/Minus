# https://github.com/todbot/node-blink1-server/blob/master/dockerfile

FROM node:8.16.1-alpine

# add necessary usb libraries
RUN apk add --update --quiet libusb libusb-dev eudev-dev git
# add build environment (will be deleted later)
RUN apk add --no-cache --virtual .gyp python2 make g++ linux-headers

# Workaround, https://github.com/npm/uid-number/issues/3#issuecomment-453727058
RUN npm config set unsafe-perm true

# install blink1-server npm version
RUN npm config set user root
RUN npm install --silent -g node-blink1-server

# revert workaround
RUN npm config set unsafe-perm true

# cleanup
RUN apk del --quiet .gyp git && rm -rf /var/cache/apk

EXPOSE 8080

ENTRYPOINT ["blink1-server", "8080"]