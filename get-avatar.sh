#!/usr/bin/env sh

USER_ID=$1
HOMESERVER_URL=${2:-https://matrix.org}

avatar_url=$(curl -s -X GET ${HOMESERVER_URL}/_matrix/client/r0/profile/${USER_ID}/avatar_url)

if [ "${avatar_url}" == "{}" ]; then
    echo $avatar_url
    exit 1
else
    short_url=$(echo "${avatar_url}"  | grep -o 'mxc.*\"' | grep -o '[^"]\+' | sed 's~mxc://~~g' )
    wget ${HOMESERVER_URL}/_matrix/media/r0/download/${short_url} -O /tmp/avatar.png
    xdg-open /tmp/avatar.png
fi
