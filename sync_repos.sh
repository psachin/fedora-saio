#!/usr/bin/env bash

pushd /home/vagrant
git clone https://github.com/openstack/python-swiftclient.git
pushd python-swiftclient
python setup.py install
popd
chown -R vagrant.vagrant python-swiftclient
popd

pushd /home/vagrant
git clone https://github.com/openstack/swift.git
pushd swift
pip install -r test-requirements.txt
pip install -r requirements.txt
python setup.py install
popd
chown -R vagrant.vagrant swift
popd
