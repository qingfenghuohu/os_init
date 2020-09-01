#!/bin/bash
yum install -y gcc-c++ wget
wget http://download.redis.io/releases/redis-5.0.7.tar.gz
tar -xzvf redis-5.0.7.tar.gz
cd redis-5.0.7
make MALLOC=libc
make install
cp redis.conf /usr/local/redis/redis.conf
wget -P /etc/systemd/system/ https://raw.githubusercontent.com/qingfenghuohu/os_init/master/redis.service
systemctl daemon-reload
pass = $(head -c 100 /dev/urandom | tr -dc a-z0-9A-Z | head -c 16)
echo "requirepass $pass" >>/usr/local/redis/redis.conf
/bin/systemctl enable redis
/bin/systemctl restart redis
echo $pass