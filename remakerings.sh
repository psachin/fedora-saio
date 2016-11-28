#!/bin/bash

# 10 nodes
# 3 replicas -> 4 nodes/1,2,3,4
# 6 replicas -> 6 nodes/5,6,7,8,9,10

set -e

pushd /etc/swift
rm -rvf *.gz
rm -rvf *.builder


swift-ring-builder object.builder create 10 3 1
swift-ring-builder object.builder add r1z1-127.0.0.1:6010/1 1
swift-ring-builder object.builder add r1z1-127.0.0.1:6010/2 1
swift-ring-builder object.builder add r1z1-127.0.0.1:6010/3 1
swift-ring-builder object.builder add r1z1-127.0.0.1:6010/4 1
swift-ring-builder object.builder rebalance

swift-ring-builder object-1.builder create 10 6 1
swift-ring-builder object-1.builder add r1z1-127.0.0.1:6010/5 2
swift-ring-builder object-1.builder add r1z1-127.0.0.1:6010/6 2
swift-ring-builder object-1.builder add r1z1-127.0.0.1:6010/7 2
swift-ring-builder object-1.builder add r1z1-127.0.0.1:6010/8 2
swift-ring-builder object-1.builder add r1z1-127.0.0.1:6010/9 2
swift-ring-builder object-1.builder add r1z1-127.0.0.1:6010/10 2
swift-ring-builder object-1.builder rebalance

swift-ring-builder object-2.builder create 10 6 1
swift-ring-builder object-2.builder add r1z1-127.0.0.1:6010/5 2
swift-ring-builder object-2.builder add r1z1-127.0.0.1:6010/6 2
swift-ring-builder object-2.builder add r1z1-127.0.0.1:6010/7 2
swift-ring-builder object-2.builder add r1z1-127.0.0.1:6010/8 2
swift-ring-builder object-2.builder add r1z1-127.0.0.1:6010/9 2
swift-ring-builder object-2.builder add r1z1-127.0.0.1:6010/10 2
swift-ring-builder object-2.builder rebalance

swift-ring-builder container.builder create 10 5 1
swift-ring-builder container.builder add r1z1-127.0.0.1:6011/1 1
swift-ring-builder container.builder add r1z1-127.0.0.1:6011/2 1
swift-ring-builder container.builder add r1z1-127.0.0.1:6011/3 1
swift-ring-builder container.builder add r1z1-127.0.0.1:6011/4 1
swift-ring-builder container.builder add r1z1-127.0.0.1:6011/5 2
swift-ring-builder container.builder add r1z1-127.0.0.1:6011/6 2
swift-ring-builder container.builder add r1z1-127.0.0.1:6011/7 2
swift-ring-builder container.builder add r1z1-127.0.0.1:6011/8 2
swift-ring-builder container.builder add r1z1-127.0.0.1:6011/9 2
swift-ring-builder container.builder add r1z1-127.0.0.1:6011/10 2
swift-ring-builder container.builder rebalance

swift-ring-builder account.builder create 10 5 1
swift-ring-builder account.builder add r1z1-127.0.0.1:6012/1 1
swift-ring-builder account.builder add r1z1-127.0.0.1:6012/2 1
swift-ring-builder account.builder add r1z1-127.0.0.1:6012/3 1
swift-ring-builder account.builder add r1z1-127.0.0.1:6012/4 1
swift-ring-builder account.builder add r1z1-127.0.0.1:6012/5 2
swift-ring-builder account.builder add r1z1-127.0.0.1:6012/6 2
swift-ring-builder account.builder add r1z1-127.0.0.1:6012/7 2
swift-ring-builder account.builder add r1z1-127.0.0.1:6012/8 2
swift-ring-builder account.builder add r1z1-127.0.0.1:6012/9 2
swift-ring-builder account.builder add r1z1-127.0.0.1:6012/10 2
swift-ring-builder account.builder rebalance

popd
