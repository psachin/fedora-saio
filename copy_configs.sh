#!/usr/bin/env bash

cp -rv /vagrant/cookbooks/swift/files/default/etc/* /etc/

if grep -e "export SAIO_BLOCK_DEVICE=/srv/swift-disk" /home/vagrant/.bashrc > /dev/null;
then
    echo "Not modifying .bashrc"
else

cat <<EOF >> /home/vagrant/.bashrc
export SAIO_BLOCK_DEVICE=/srv/swift-disk
EOF

fi

if grep -e "export SWIFT_TEST_CONFIG_FILE=/etc/swift/test.conf" /home/vagrant/.bashrc > /dev/null;
then
    echo "Not modifying .bashrc"
else

cat <<EOF >> /home/vagrant/.bashrc
export SWIFT_TEST_CONFIG_FILE=/etc/swift/test.conf
EOF

fi

if grep -e "export PATH=${PATH}:/home/vagrant/bin" /home/vagrant/.bashrc > /dev/null;
then
    echo "Not modifying .bashrc"
else

cat <<EOF >> /home/vagrant/.bashrc
export PATH=${PATH}:/home/vagrant/bin
EOF

fi

if grep -e "export ST_AUTH=http://192.168.11.33:8080/auth/v1.0" /home/vagrant/.bashrc > /dev/null;
then
    echo "Not modifying .bashrc"
else

cat <<EOF >> /home/vagrant/.bashrc
export ST_AUTH=http://192.168.11.33:8080/auth/v1.0
export ST_USER=test:tester
export ST_KEY=testing
EOF

fi
