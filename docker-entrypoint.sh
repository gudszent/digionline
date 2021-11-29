#!/bin/sh

sed -i 's/"domain": "localhost"/"domain": "'$DOMAIN'"/' config.json && sed -i 's/"email": ""/"email": "'$EMAIL'"/' config.json && sed -i 's/"password": ""/"password": "'$PASSWORD'"/' config.json

npm start
