#!/usr/bin/env sh

USER_ID=$1
HOMESERVER_URL=${2:-https://matrix.org}

avatar_url=$(curl -s -X GET ${HOMESERVER_URL}/_matrix/client/r0/profile/${USER_ID}/avatar_url | jq -r .avatar_url)

echo "avatar_url is ${avatar_url}"

server_name=$(echo "${avatar_url}" | sed -e "s~mxc://~~g")

echo "server_name is ${server_name}"

media_id=$(echo "${server_name}" | grep -oe "[^\/]*$" )

echo "media_is is ${media_id}"

echo "opening media..."

wget -q ${HOMESERVER_URL}/_matrix/media/r0/download/${server_name}/${media_id} -O /tmp/avatar.png

# this could be just any image viewer maybe with xdg-open ?
xdg-open /tmp/avatar.png
