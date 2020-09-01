#!/bin/bash
rm -rf redis-5.0.7.tar.gz redis-5.0.7 /etc/systemd/system/redis.service /usr/local/redis/redis.conf
mkdir -p /usr/local/redis/
yum install -y centos-release-scl scl-utils-build wget
yum install -y devtoolset-8-toolchain
scl enable devtoolset-8 bash
# 永久开启gcc 8
# echo "source /opt/rh/devtoolset-8/enable" >>/etc/profile
wget http://download.redis.io/releases/redis-6.0.6.tar.gz
tar -zxvf redis-6.0.6.tar.gz
cd redis-6.0.6
make MALLOC=libc
make install
cp redis.conf /usr/local/redis/redis.conf
wget -P /etc/systemd/system/ https://raw.githubusercontent.com/qingfenghuohu/os_init/master/redis.service
systemctl daemon-reload
pass=$(head -c 100 /dev/urandom | tr -dc a-z0-9A-Z | head -c 16)
echo "requirepass $pass" >> /usr/local/redis/redis.conf
/bin/systemctl enable redis
/bin/systemctl restart redis
echo $pass
cd ..
rm -rf redis-6.0.6.tar.gz redis-6.0.6