#!/bin/bash

file = /usr/bin/v2ray/v2ray

if [ ! -f "$file" ]; then

    yum -y install ntpdate crontab wget

    /bin/systemctl restart crond.service

    /bin/systemctl enable crond.service

    timedatectl set-timezone Asia/Shanghai

    ntpdate -u  pool.ntp.org

    echo "*/20 * * * * /usr/sbin/ntpdate pool.ntp.org > /dev/null 2>&1" >> /var/spool/cron/root

    curl -L -s https://install.direct/go.sh | bash

    rm -f /etc/v2ray/config.json

    wget -P /etc/v2ray/ https://raw.githubusercontent.com/qingfenghuohu/os_init/master/config.json

    /bin/systemctl enable v2ray

fi


curl -L -s https://raw.githubusercontent.com/qingfenghuohu/os_init/master/bbr.sh | bash

reboot

echo "success"