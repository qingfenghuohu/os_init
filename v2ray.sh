#!/bin/bash
yum -y install ntpdate crontab
/bin/systemctl restart crond.service
/bin/systemctl enable crond.service
timedatectl set-timezone Asia/Shanghai
ntpdate -u  pool.ntp.org

echo "*/20 * * * * /usr/sbin/ntpdate pool.ntp.org > /dev/null 2>&1" >> /var/spool/cron/root

curl -L -s https://install.direct/go.sh | bash
