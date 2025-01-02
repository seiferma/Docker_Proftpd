#!/bin/sh

echo Testing configuration
proftpd --configtest --config /etc/proftpd/proftpd.conf

echo Starting server
exec proftpd --nodaemon --config /etc/proftpd/proftpd.conf
