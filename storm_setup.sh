#!/bin/bash

mkdir -p /home/ubuntu/storage/data/zookeeper
mkdir -p /home/ubuntu/logs/zookeeper

echo $1 > /home/ubuntu/storage/data/zookeeper/myid

cd /home/ubuntu/software
wget "http://apache.arvixe.com/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz"
tar -xvzf zookeeper-3.4.6.tar.gz
wget "http://pages.cs.wisc.edu/~akella/CS838/F15/assignment3/apache-storm-0.9.5.tar.gz"
tar -xvzf apache-storm-0.9.5.tar.gz
cd ..
