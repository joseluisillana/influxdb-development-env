#!/usr/bin/env bash
# this script installs the puppet modules we need, 
#and tries to do tricks with setting local repository for ubuntu updates

# Install wget

sudo apt-get install -qy wget;

sed -e '/templatedir/ s/^#*/#/' -i.back /etc/puppet/puppet.conf

## set local/fastest mirror and local timezone
mv /etc/apt/sources.list /etc/apt/sources.list.orig
cat > /etc/apt/sources.list <<EOF
deb mirror://mirrors.ubuntu.com/mirrors.txt trusty main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-backports main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-security main restricted universe multiverse

EOF
sudo apt-get update
export tz=`wget -qO - http://geoip.ubuntu.com/lookup | sed -n -e 's/.*<TimeZone>\(.*\)<\/TimeZone>.*/\1/p'` &&  sudo timedatectl set-timezone $tz

mkdir -p /etc/puppet/modules;
if [ ! -d /etc/puppet/modules/file_concat ]; then
 puppet module install ispavailability/file_concat
fi
if [ ! -d /etc/puppet/modules/apt ]; then
 puppet module install puppetlabs-apt --version 1.8.0
fi
if [ ! -d /etc/puppet/modules/java ]; then
 puppet module install puppetlabs-java
fi
if [ ! -d /etc/puppet/modules/influxdb ]; then
 puppet module install golja/influxdb
fi
if [ ! -d /etc/puppet/modules/influxdb ]; then
 puppet module install rplessl-influxdb
fi

