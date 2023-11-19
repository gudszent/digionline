FROM node:21-alpine3.18

# Create app directory
WORKDIR /usr/src/app

# Bundle app source
COPY . .

# Create config.json from the sample
RUN cp config.sample.json config.json && \
# Install production only dependencies
    npm install --only=production && \
# Install typescript for conversion
    npm install -g typescript && \
# Convert typescript source to javascript
    npx tsc main.ts && \
# Remove typescript
    npm uninstall -g typescript && \
# Create epg.xml
    touch epg.xml && \
#Fix permission on docker-entrypoint.sh
    chmod +x docker-entrypoint.sh

EXPOSE 9999
ENTRYPOINT ["/usr/src/app/docker-entrypoint.sh" ]

# Build docker image:
#   sudo docker build -t digionline https://github.com/szabbenjamin/digionline.git
# Create and run docker container:
#   sudo docker run -d -p 9999:9999 --restart unless-stopped --env DOMAIN=valami.local --env EMAIL=a@b.hu --env PASSWORD=jelszo --name container-digionline digionline
# Kodi PVR IPTV Simple Client addon
#   TV channel list: http://localhost:9999/channels_IPTV.m3u8
#   TV EPG source: http://localhost:9999/epg.xml
