#!/bin/sh
USER="guest"
[[ -z $PUID ]] && PUID="1000"

# Unsure why this is persisted across builds even with docker build --no-cache
grep $USER /etc/passwd && deluser $USER
adduser --disabled-password --uid "$PUID" "$USER"

python