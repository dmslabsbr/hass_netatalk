#!/bin/bash
#!/usr/bin/with-contenv bashio

set +u

RED='\033[0;31m'
NC='\033[0m' # No Color

function ech {
  echo -e "${RED} $1 ${NC}"
}

USERNAME=dms


ech "Netatalk start"

ech "Protection Mode is $(bashio::addon.protected)"

# Clean out old locks
/bin/rm -f /var/lock/netatalk

#echo "netatalk -d"
#netatalk -d

echo -e "${RED} UserAdd ${NC}"
#useradd --create-home --shell /bin/bash dms


addgroup "${USERNAME}"
#adduser -D -g '' dms
adduser -D -H -G "${USERNAME}" -s /bin/false "${USERNAME}"
echo 'dms:dms' | chpasswd


ech "Mapping volume"
disk=hd3tb
mkdir -p /$disk

mount -t auto /dev/disk/by-label/$disk /$disk -o nosuid,relatime,noexec

#bashio::log.green "service netatalk start"
#service netatalk start

#bashio::log.green "service netatalk status"
#service netatalk status

ech "netatalk -v"
netatalk -v


ech "afp.conf"
cat /etc/afp.conf

echo " - "

ech "netatalk -d"
netatalk -d