#!/bin/bash

yum -y install ntpdate crontab wget

/bin/systemctl restart crond.service

/bin/systemctl enable crond.service

timedatectl set-timezone Asia/Shanghai

ntpdate -u  pool.ntp.org

mkdir -p /tmp/v2ray/

wget -P /tmp/v2ray/ https://raw.githubusercontent.com/qingfenghuohu/os_init/master/config.json

wget -P /tmp/v2ray/ https://raw.githubusercontent.com/qingfenghuohu/os_init/master/bbr.sh

chmod +x /tmp/v2ray/bbr.sh

echo "*/20 * * * * /usr/sbin/ntpdate pool.ntp.org > /dev/null 2>&1" >> /var/spool/cron/root

curl -L -s https://install.direct/go.sh | bash

rm -f /etc/v2ray/config.json

cp /tmp/v2ray/config.json /etc/v2ray/config.json

/bin/systemctl enable v2ray

/bin/sh /tmp/v2ray/bbr.sh