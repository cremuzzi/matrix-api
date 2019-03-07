#!/usr/bin/env sh

USER_ID=$1
HOMESERVER_URL=${2:-https://matrix.org}

avatar_url=$(curl -s -X GET ${HOMESERVER_URL}/_matrix/client/r0/profile/${USER_ID}/avatar_url | jq -r .avatar_url)

avatar_url=$(echo "${avatar_url}" | sed -e "s~mxc://~~g")

wget ${HOMESERVER_URL}/_matrix/media/r0/download/${avatar_url} -O /tmp/avatar.png

xdg-open /tmp/avatar.png
