#!/bin/bash

/bin/systemctl stop firewalld

/bin/systemctl disable firewalld

file = /usr/bin/v2ray/v2ray

if [ ! -f "$file" ]; then

    yum -y install ntpdate crontab wget

    /bin/systemctl restart crond.service

    /bin/systemctl enable crond.service

    timedatectl set-timezone Asia/Shanghai

    ntpdate -u  pool.ntp.org

    echo "*/20 * * * * /usr/sbin/ntpdate pool.ntp.org > /dev/null 2>&1" >> /var/spool/cron/root

    curl -L -s https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.shhttps://install.direct/go.sh | bash

    rm -f /etc/v2ray/config.json

    wget -P /etc/v2ray/ https://raw.githubusercontent.com/qingfenghuohu/os_init/master/config.json

    /bin/systemctl enable v2ray

    echo "v2ray install success"

fi

bbr=`lsmod|grep bbr|awk '{print $1}'`

if [[ "tcp_bbr" != $bbr ]]; then

    bbr = `lsmod|grep bbr|awk '{print $1}'`

    curl -L -s https://raw.githubusercontent.com/qingfenghuohu/os_init/master/bbr.sh | bash

    reboot

    echo "bbr install success"

fi


