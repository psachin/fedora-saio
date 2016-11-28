#!/usr/bin/env bash

pushd /home/vagrant
git clone https://github.com/openstack/python-swiftclient.git
chown -R vagrant.vagrant python-swiftclient
pushd python-swiftclient
python setup.py develop;
popd
popd

pushd /home/vagrant
git clone https://github.com/openstack/swift.git
chown -R vagrant.vagrant swift
pushd swift
pip install -r test-requirements.txt
pip install -r requirements.txt
python setup.py develop
popd
popd
