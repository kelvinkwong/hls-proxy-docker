#!/usr/bin/env bash
set -e

ID=$1
DIR=${OUTDIR:-"/var/hls"}
MINUTES=${2:-10}
OPTIONS=${3:-'-d'}
PLAYLIST=${4:-"https://openwebinars.net/academia/hls/$ID.m3u8"}
TIMEOUT=$(echo  $MINUTES*60 | bc)
[ -d "$DIR/${ID::2}/$ID" ] && find "$DIR/${ID::2}/$ID" -type f -size 21c -exec rm {} \;
pipenv run -- ./hlsproxy.py $OPTIONS -o "$DIR/${ID::2}/$ID" $PLAYLIST &
echo "Process $! will be killed after $TIMEOUT seconds"
sleep $TIMEOUT && kill -15 $!
echo "Sended SIGTERM to $!"
