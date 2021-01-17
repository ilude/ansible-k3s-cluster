#!/bin/bash
# exit if this script errors
set -e

# setup local timezone
ln -snf /etc/localtime /usr/share/zoneinfo/${TZ:-America/New_York} 
echo ${TZ:-America/New_York} > /etc/timezone 

# setup user id and group id
export PUID=${PUID:-919}
export PGID=${PGID:-919}

groupmod -o -g "$PGID" ${USER}
usermod -o -u "$PUID" ${USER}

#mkdir -p /etc/ansible && touch /etc/ansible/hosts 

chown -R ${USER}:${USER} /home/${USER}

exec /usr/bin/sudo --preserve-env --set-home -u ${USER} -g ${USER} $@
