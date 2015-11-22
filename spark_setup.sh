#!/bin/bash

mkdir -p /home/ubuntu/storage/data/spark/rdds_shuffle
mkdir -p /home/ubuntu/logs/spark
mkdir -p /home/ubuntu/storage/data/spark/worker

cd /home/ubuntu/software
wget "http://apache.arvixe.com/spark/spark-1.5.0/spark-1.5.0-bin-hadoop2.6.tgz"
tar -xvzf spark-1.5.0-bin-hadoop2.6.tgz
cd ..
