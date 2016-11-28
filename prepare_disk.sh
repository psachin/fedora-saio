#!/usr/bin/env bash

mkdir /srv/node
truncate -s 1GB /srv/swift-disk
mkfs.xfs /srv/swift-disk

cat <<EOF >/root/vdb.sfdisk
label: dos
label-id: 0x04691d93
device: /dev/vdb
unit: sectors

/dev/vdb1 : start=        2048, size=     4192256, type=83

EOF

sfdisk /dev/vdb < /root/vdb.sfdisk
mkfs.xfs /dev/vdb1

if grep -e "^\/srv/swift-disk" /etc/fstab > /dev/null;
then
    echo "Not modifying /etc/fstab"
else

cat <<EOF >>/etc/fstab
/srv/swift-disk /mnt/sdb1 xfs loop,noatime,nodiratime,nobarrier,logbufs=8 0 0
/dev/vdb1       /mnt/sdb2 xfs noatime,nodiratime,nobarrier,logbufs=8 0 0

EOF

fi


mkdir /mnt/sdb1
mkdir /mnt/sdb2

mount /mnt/sdb1
mount /mnt/sdb2

for i in {1..4};
do
	mkdir /mnt/sdb1/${i}
done

for i in {5..10};
do
	mkdir /mnt/sdb2/${i}
done

chown vagrant:vagrant /mnt/sdb1/*
chown vagrant:vagrant /mnt/sdb2/*

for x in {1..4};
do
	ln -s /mnt/sdb1/$x /srv/node/$x;
done

for y in {5..10};
do
	ln -s /mnt/sdb2/$y /srv/node/$y;
done

mkdir -p /var/cache/swift
chown vagrant:vagrant /var/cache/swift*

mkdir -p /var/run/swift
chown -R vagrant:vagrant /var/run/swift

mkdir -p /var/log/swift
chown -R root:adm /var/log/swift
chmod -R g+w /var/log/swift

# **Make sure to include the trailing slash after /srv/node/$x/**
for x in {1..10}; do chown -R vagrant:vagrant /srv/node/$x/; done
