#!/usr/bin/env sh

USER_ID=$1

avatar_url=$(curl -s -X GET https://matrix.agetic.gob.bo/_matrix/client/r0/profile/@${USER_ID}:agetic.gob.bo | jq -r .avatar_url)

echo "avatar_url is ${avatar_url}"

media_id=$(echo "${avatar_url}" | grep -oe "[^\/]*$" )

echo "media_is is ${media_id}"

echo "opening media..."

wget -q https://matrix.agetic.gob.bo/_matrix/media/r0/download/agetic.gob.bo/${media_id} -O /tmp/avatar.png

feh -. /tmp/avatar.png
