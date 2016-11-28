#!/bin/bash

# 10 nodes
# 3 replicas -> 4 nodes/1,2,3,4
# 6 replicas -> 6 nodes/5,6,7,8,9,10

set -e

pushd /etc/swift
rm -rvf *.gz
rm -rvf *.builder


swift-ring-builder object.builder create 10 3 1
for i in {1..4};
do
	swift-ring-builder object.builder add r1z1-127.0.0.1:6010/${i} 1
done
swift-ring-builder object.builder rebalance

swift-ring-builder object-1.builder create 10 6 1
swift-ring-builder object-2.builder create 10 6 1
for i in {5..10};
do
	swift-ring-builder object-1.builder add r1z1-127.0.0.1:6010/${i} 2
	swift-ring-builder object-2.builder add r1z1-127.0.0.1:6010/${i} 2
done
swift-ring-builder object-1.builder rebalance
swift-ring-builder object-2.builder rebalance

swift-ring-builder container.builder create 10 5 1
for i in {1..10};
do
	swift-ring-builder container.builder add r1z1-127.0.0.1:6011/${i} 1
done
swift-ring-builder container.builder rebalance

swift-ring-builder account.builder create 10 5 1
for i in {1..10};
do
	swift-ring-builder account.builder add r1z1-127.0.0.1:6012/${i} 1
done
swift-ring-builder account.builder rebalance

popd
