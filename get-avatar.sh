#!/usr/bin/env sh

USER_ID=$1
SERVER_NAME=$2

avatar_url=$(curl -s -X GET https://matrix.org/_matrix/client/r0/profile/${USER_ID}/avatar_url | jq -r .avatar_url)

echo "avatar_url is ${avatar_url}"

server_name=$(echo "${avatar_url}" | sed -e "s~mxc://~~g")

echo "server_name is ${server_name}"

media_id=$(echo "${server_name}" | grep -oe "[^\/]*$" )

echo "media_is is ${media_id}"

echo "opening media..."

wget -q https://matrix.org/_matrix/media/r0/download/${server_name}/${media_id} -O /tmp/avatar.png

# this could be just any image viewer maybe with xdg-open ?
xdg-open /tmp/avatar.png
