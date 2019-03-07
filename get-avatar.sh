#!/usr/bin/env sh

USER_ID=$1
SERVER_URL=$2
SERVER_NAME=$3

avatar_url=$(curl -s -X GET ${SERVER_URL}/_matrix/client/r0/profile/@${USER_ID}:${SERVER_NAME}/avatar_url | jq -r .avatar_url)

echo "avatar_url is ${avatar_url}"

media_id=$(echo "${avatar_url}" | grep -oe "[^\/]*$" )

echo "media_is is ${media_id}"

echo "opening media..."

wget -q ${SERVER_URL}/_matrix/media/r0/download/${SERVER_NAME}/${media_id} -O /tmp/avatar.png

# this could be just any image viewer maybe with xdg-open ?
xdg-open /tmp/avatar.png
