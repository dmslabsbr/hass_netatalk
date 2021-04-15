
#FROM balenalib/rpi-raspbian:bullseye
ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

ENV netatalk_version 3.1.12

RUN apk add --no-cache netatalk nano \
    exfat-utils \
    fuse \  
    fuse-exfat \
    fuse-exfat-utils \
\
            dbus \
        udev \
        hwids-udev \
        device-mapper-udev \
        attr \
        e2fsprogs \
        util-linux \
        e2fsprogs-extra \
        avahi \
        avahi-compat-libdns_sd \
        avahi-tools \
        curl \
        netatalk

#RUN apt-get update && \
#    apt-get install -y netatalk fuse exfat-fuse exfat-utils apt-utils

#RUN apt-get update && \
#    apt-get install -y udev \
#        attr \
#        e2fsprogs \
#        util-linux

#RUN useradd --create-home --shell /bin/bash pi && \
#    echo 'pi:pi1234' | chpasswd
#RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN adduser -D -g '' pi && \
    echo 'pi:pi' | chpasswd

# Copy data
COPY rootfs /
RUN mkdir -p /novo

ADD afp.conf /etc/netatalk
COPY afp.conf /etc

COPY run.sh /
RUN chmod a+x /run.sh


WORKDIR /data

EXPOSE 548 636

CMD [ "/run.sh" ]