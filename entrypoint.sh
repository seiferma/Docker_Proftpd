#!/bin/sh

USER_NAME=app
GROUP_NAME=app
DATA_PATH=/srv/app-data

echo "Generating user account"
if [[ "$APP_GID" == "" ]]; then
    export APP_GID=1000
fi
if [[ "$APP_UID" == "" ]]; then
    export APP_UID=1000
fi

addgroup -g $APP_GID $GROUP_NAME
adduser -D -H -G $GROUP_NAME -u $APP_UID $USER_NAME

mkdir -p $DATA_PATH
chown $USER_NAME:$GROUP_NAME $DATA_PATH

mkdir -p /run/proftpd/
chown -R $USER_NAME:$GROUP_NAME /run/proftpd/

# generate passwd file
if [ -f /etc/proftpd/ftpd.passwd.in ]; then
    sed 's#1001:1001#'$APP_UID':'$APP_GID'#g' /etc/proftpd/ftpd.passwd.in > /etc/proftpd/ftpd.passwd
    chmod 640 /etc/proftpd/ftpd.passwd
    chown $USER_NAME:$GROUP_NAME /etc/proftpd/ftpd.passwd
fi

if [ "$1" == "default" ]; then
    su-exec $USER_NAME /start.sh
else
    exec "$@"
fi