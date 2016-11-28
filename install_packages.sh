#!/usr/bin/env bash

dnf update -y

dnf install -y fedora-packager \
	rpmdevtools \
	python-d2to1 \
	python-oslo-sphinx \
	python-pbr \
	python-sphinx \
	langpacks-en \
	git-review


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

pip install --upgrade pip
pip install -U xattr
pip install tox
pip install bpython
