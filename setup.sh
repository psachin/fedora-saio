#!/usr/bin/env bash

date > /etc/vagrant_provisioned_at

dnf update -y

dnf install -y fedora-packager \
	rpmdevtools \
	python-d2to1 \
	python-oslo-sphinx \
	python-pbr \
	python-sphinx

dnf install -y emacs-nox \
	rsyslog \
	wget \
	@development-tools \
	pypy \
	openssl-libs  \
	openssl-devel

dnf install -y curl \
	gcc \
	memcached \
	rsync \
	sqlite \
	xfsprogs \
	git-core \
	libffi-devel \
	xinetd \
	liberasurecode-devel \
	python-setuptools \
	python-coverage \
	python-devel \
	python3-devel \
	python-nose \
	pyxattr \
	python-eventlet \
	python-greenlet \
	python-paste-deploy \
	python-netifaces \
	python-pip \
	python-dns \
	python-mock \
	redhat-rpm-config \
	rsync-daemon \
	python-pyeclib \
	python3-pyeclib


mkdir /srv
truncate -s 1GB /srv/swift-disk
mkfs.xfs /srv/swift-disk

cat <<EOF >>/etc/fstab
/srv/swift-disk /mnt/sdb1 xfs loop,noatime,nodiratime,nobarrier,logbufs=8 0 0
EOF

mkdir /mnt/sdb1
mount /mnt/sdb1
mkdir /mnt/sdb1/1 /mnt/sdb1/2 /mnt/sdb1/3 /mnt/sdb1/4
chown vagrant:vagrant /mnt/sdb1/*
for x in {1..4};
do ln -s /mnt/sdb1/$x /srv/$x;
done
mkdir -p /srv/1/node/sdb1 /srv/1/node/sdb5 \
      /srv/2/node/sdb2 /srv/2/node/sdb6 \
      /srv/3/node/sdb3 /srv/3/node/sdb7 \
      /srv/4/node/sdb4 /srv/4/node/sdb8 \
      /var/run/swift
mkdir -p /var/run/swift
chown -R vagrant:vagrant /var/run/swift
# **Make sure to include the trailing slash after /srv/$x/**
for x in {1..4}; do chown -R vagrant:vagrant /srv/$x/; done

cat <<EOF > /etc/rc.d/rc.local
mkdir -p /var/cache/swift /var/cache/swift2 /var/cache/swift3 /var/cache/swift4
chown vagrant:vagrant /var/cache/swift*
mkdir -p /var/run/swift
chown vagrant:vagrant /var/run/swift
EOF


pushd /home/vagrant; git clone https://github.com/openstack/python-swiftclient.git
pushd python-swiftclient; python setup.py develop; cd -
popd
popd


pushd /home/vagrant; git clone https://github.com/openstack/swift.git
pushd swift; pip install -r requirements.txt; python setup.py develop
popd
popd

pip install --upgrade pip
pip install -U xattr
pushd  /home/vagrant/swift
pip install -r test-requirements.txt
popd

setsebool -P rsync_full_access 1

cp -rv /vagrant/cookbooks/swift/files/default/etc/* /etc/

systemctl restart xinetd.service
systemctl enable rsyncd.service
systemctl start rsyncd.service

systemctl enable memcached.service
systemctl start memcached.service

mkdir -p /var/log/swift

chown -R root:adm /var/log/swift
chmod -R g+w /var/log/swift
systemctl restart rsyslog.service

mkdir -p /home/vagrant/bin
cp -rv /home/vagrant/swift/doc/saio/bin/* /home/vagrant/bin
chmod +x /home/vagrant/bin/*

cat <<EOF >>/home/vagrant/.bashrc
export SAIO_BLOCK_DEVICE=/srv/swift-disk
EOF

cat <<EOF >>/home/vagrant/.bashrc
export SWIFT_TEST_CONFIG_FILE=/etc/swift/test.conf
EOF

cat <<EOF >>/home/vagrant/.bashrc
export PATH=${PATH}:/home/vagrant/bin
EOF

cat <<EOF >>/home/vagrant/.bashrc
export ST_AUTH=http://192.168.11.33:8080/auth/v1.0
export ST_USER=test:tester
export ST_KEY=testing
EOF

sh /home/vagrant/bin/remakerings
sh /home/vagrant/bin/startmain
