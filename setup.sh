if [ $# -eq 0 ]
  then
    echo "Master ip not supplied"
    exit 1
fi

MASTER_IP=$1

sudo apt-get update --fix-missing
sudo apt-get install vim
sudo apt-get install openjdk-7-jdk
sudo apt-get install pdsh

mkdir -p /home/ubuntu/logs
mkdir -p /home/ubuntu/software
mkdir -p /home/ubuntu/storage
mkdir -p /home/ubuntu/workload
mkdir -p /home/ubuntu/logs/apps
mkdir -p /home/ubuntu/logs/hadoop
mkdir -p /home/ubuntu/storage/data/local/nm
mkdir -p /home/ubuntu/storage/data/local/tmp
mkdir -p /home/ubuntu/storage/hdfs/hdfs_dn_dirs
mkdir -p /home/ubuntu/storage/hdfs/hdfs_nn_dir
mkdir -p /home/ubuntu/workload

cd /home/ubuntu

wget "http://pages.cs.wisc.edu/~akella/CS838/F15/assignment1/conf.tar.gz"
wget "http://pages.cs.wisc.edu/~akella/CS838/F15/assignment1/run.sh"
wget "http://apache.arvixe.com/hadoop/common/hadoop-2.6.0/hadoop-2.6.0.tar.gz"

tar -xvzf conf.tar.gz 
cd conf
sed -i s/MASTER_IP/$MASTER_IP/g core-site.xml 
sed -i s/MASTER_IP/$MASTER_IP/g hdfs-site.xml 
sed -i s/MASTER_IP/$MASTER_IP/g hive-site.xml
sed -i s/MASTER_IP/$MASTER_IP/g mapred-site.xml
sed -i s/MASTER_IP/$MASTER_IP/g yarn-site.xml
sed -i 's/home\/ubuntu\/storage\/hdfs\/hdfs_dn_dirs/mnt\/hdfs\/hdfs_dn_dirs/g' hdfs-site.xml
cd ..

mv hadoop-2.6.0.tar.gz software/
cd software
tar -xvzf hadoop-2.6.0.tar.gz
cd ..

sudo mkfs -t ext3 /dev/sda4
sudo mkdir -p /mnt/hdfs
sudo mount /dev/sda4 /mnt/hdfs
sudo mkdir -p /mnt/hdfs/hdfs_dn_dirs
sudo chown ubuntu:ubuntu /mnt/hdfs/hdfs_dn_dirs

echo "" >> ~/.bashrc
echo "source ~/run.sh" >> ~/.bashrc
#/home/ubuntu/software/hadoop-2.6.0/bin/hadoop namenode -format

echo "create instances if master"
echo "Edit /etc/hosts"
