#!/bin/bash

mkdir -p /home/ninjah/storage/data/spark/rdds_shuffle
mkdir -p /home/ninjah/logs/spark
mkdir -p /home/ninjah/storage/data/spark/worker

cd /home/ninjah/software
wget "http://apache.arvixe.com/spark/spark-1.5.0/spark-1.5.0-bin-hadoop2.6.tgz"
tar -xvzf spark-1.5.0-bin-hadoop2.6.tgz
cd ..
