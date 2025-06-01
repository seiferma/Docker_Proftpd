FROM alpine:3.22

RUN apk add --no-cache su-exec
ADD entrypoint.sh start.sh /
ADD proftpd.conf /etc/proftpd/proftpd.conf
EXPOSE 2121 2122 2123
ENTRYPOINT ["/entrypoint.sh"]
CMD ["default"]

ARG VERSION
RUN apk add --no-cache "proftpd=${VERSION}" "proftpd-mod_tls=${VERSION}" "proftpd-utils=${VERSION}" libcap-setcap && \
    setcap CAP_SYS_CHROOT=+eip /usr/sbin/proftpd
