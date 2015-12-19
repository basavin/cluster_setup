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

mkdir -p /home/ninjah/logs
mkdir -p /home/ninjah/software
mkdir -p /home/ninjah/storage
mkdir -p /home/ninjah/workload
mkdir -p /home/ninjah/logs/apps
mkdir -p /home/ninjah/logs/hadoop
mkdir -p /home/ninjah/storage/data/local/nm
mkdir -p /home/ninjah/storage/data/local/tmp
mkdir -p /home/ninjah/storage/hdfs/hdfs_dn_dirs
mkdir -p /home/ninjah/storage/hdfs/hdfs_nn_dir
mkdir -p /home/ninjah/workload

cd /home/ninjah

wget "http://pages.cs.wisc.edu/~akella/CS838/F15/assignment1/conf.tar.gz"
wget "http://pages.cs.wisc.edu/~akella/CS838/F15/assignment2/run.sh"

tar -xvzf conf.tar.gz 
cd conf
sed -i s/ubuntu/ninjah/g *.xml 
sed -i s/MASTER_IP/$MASTER_IP/g core-site.xml 
sed -i s/MASTER_IP/$MASTER_IP/g hdfs-site.xml 
sed -i s/MASTER_IP/$MASTER_IP/g hive-site.xml
sed -i s/MASTER_IP/$MASTER_IP/g mapred-site.xml
sed -i s/MASTER_IP/$MASTER_IP/g yarn-site.xml
sed -i 's/home\/ninjah\/storage\/hdfs\/hdfs_dn_dirs/mnt\/hdfs\/hdfs_dn_dirs/g' hdfs-site.xml
sed -i 's/home\/ninjah\/storage\/data\/local\/nm/mnt\/hdfs\/storage\/data\/local\/nm/g' yarn-site.xml
sed -i 's/<value>23552<\/value>/<value>102400<\/value>/g' yarn-site.xml
sed -i 's/<value>5<\/value>/<value>24<\/value>/g' yarn-site.xml
cd ..

cd software
wget "http://apache.arvixe.com/hadoop/common/hadoop-2.6.0/hadoop-2.6.0.tar.gz"
tar -xvzf hadoop-2.6.0.tar.gz
cd ..

sudo mkfs -t ext3 /dev/sda4
sudo mkdir -p /mnt/hdfs
sudo mount /dev/sda4 /mnt/hdfs
sudo mkdir -p /mnt/hdfs/hdfs_dn_dirs
sudo chown ninjah:ninjah /mnt/hdfs/hdfs_dn_dirs
sudo mkdir -p /mnt/hdfs/logs
sudo chown ninjah:ninjah /mnt/hdfs/logs
sudo mkdir -p /mnt/hdfs/storage
sudo chown ninjah:ninjah /mnt/hdfs/storage


echo "Edit /etc/hosts"
