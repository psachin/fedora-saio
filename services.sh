#!/usr/bin/env bash

setsebool -P rsync_full_access 1

systemctl restart xinetd.service

systemctl enable rsyncd.service
systemctl start rsyncd.service

systemctl enable memcached.service
systemctl start memcached.service

systemctl restart rsyslog.service

date > /etc/vagrant_provisioned_at
