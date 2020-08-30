#!/bin/bash

/bin/systemctl stop firewalld

/bin/systemctl disable firewalld

file = /usr/bin/v2ray/v2ray

if [ ! -f "$file" ]; then

    yum -y install ntpdate crontab wget

    /bin/systemctl restart crond.service

    /bin/systemctl enable crond.service

    timedatectl set-timezone Asia/Shanghai

    ntpdate -u pool.ntp.org

    curl https://raw.githubusercontent.com/qingfenghuohu/os_init/master/install-v2ray.sh|bash

    curl https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-dat-release.sh|bash

    rm -f /etc/systemd/system/v2ray.service

    rm -f /etc/v2ray/config.json

    wget -P /etc/systemd/system/ https://raw.githubusercontent.com/qingfenghuohu/os_init/master/v2ray.service

    wget -P /etc/v2ray/ https://raw.githubusercontent.com/qingfenghuohu/os_init/master/config.json

    systemctl daemon-reload

    /bin/systemctl enable v2ray

    /bin/systemctl start v2ray

    echo "*/20 * * * * /usr/sbin/ntpdate pool.ntp.org > /dev/null 2>&1" >> /var/spool/cron/root

    echo "1,10 * * * * /bin/systemctl restart v2ray > /dev/null 2>&1" >> /var/spool/cron/root

    echo "v2ray install success"

fi

bbr=`lsmod|grep bbr|awk '{print $1}'`

if [[ "tcp_bbr" != $bbr ]]; then

    bbr = `lsmod|grep bbr|awk '{print $1}'`

    curl -L -s https://raw.githubusercontent.com/qingfenghuohu/os_init/master/bbr.sh | bash

    reboot

    echo "bbr install success"

fi