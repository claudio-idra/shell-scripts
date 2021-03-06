#!/bin/bash
# Based on: https://spark.apache.org/docs/1.1.0/building-with-maven.html
# Purpose: this script will automatically compile and install
# the newest version of maven and Apache Spark via the github sources
# Software requirements: Ubuntu 14.04 LTS 64-bit, git, build-essential,
# ant, unp, python2.7, java 1.7.0 or higher
# Minimum RAM requirements for this script: 2 Gigabytes of RAM (maybe even more) 
# Please make sure to close any web browser windows and any other 
# memory hogging applications before running this memory intensive bash script.
# First uninstall any conflicting binary packages of maven and maven2:
cd
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:marutter/rrutter
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:marutter/c2d4u
sudo DEBIAN_FRONTEND=noninteractive apt-get update
# Install tools required to build maven and Apache Spark with sparkR support:
sudo apt-get build-dep maven maven2
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes  install  r-base-core r-base
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes  install  git build-essential python-protobuf protobuf-compiler
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes  install  ant unp python2.7 openjdk-7-jre-headless 
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes  purge maven maven2
# Also remove any previously installed versions of Apache Spark:
sudo rm -rf spark*
sudo rm -rf /usr/local/spark*
# install newest version of maven
rm -rf maven*
git clone https://github.com/apache/maven.git
cd maven
ant -Dmaven.home="$HOME/apps/maven/apache-maven-SNAPSHOT"
cd ~/maven/apache-maven/target
unp apache-maven-*-bin.tar.gz
sudo rm /usr/bin/mvn
sudo ln -s ~/maven/apache-maven/target/apache-maven-*/bin/mvn  /usr/bin/mvn
mvn -v
# example of Terminal output:
#Apache Maven 3.3.2-SNAPSHOT
#Maven home: $HOME/maven/apache-maven/target/apache-maven-3.3.2-SNAPSHOT
#Java version: 1.7.0_76, vendor: Oracle Corporation
#Java home: /usr/lib/jvm/java-7-oracle/jre
#Default locale: en_US, platform encoding: UTF-8
#OS name: "linux", version: "4.0.0-040000rc3-lowlatency", arch: "amd64", family: "unix"
# install SparkR-pkg
cd
rm -rf SparkR-pkg/
git clone https://github.com/amplab-extras/SparkR-pkg.git
cd SparkR-pkg/
SPARK_VERSION=1.4.0 USE_MAVEN=1 ./install-dev.sh
# ./sparkR examples/pi.R local[2]
# install newest version of Apache Spark:
cd
git clone git://github.com/apache/spark.git
cd spark
# increase MaxPermSize to avoid out-of-memory errors during compile process:
export MAVEN_OPTS="-Xmx2g -XX:MaxPermSize=512M -XX:ReservedCodeCacheSize=512m"
mvn -PsparkR -DskipTests clean package
# End result of Apache Spark build process should look
# something like this (without any memory errors):
# [INFO] ------------------------------------------------------------------------
# [INFO] Reactor Summary:
# [INFO] 
# [INFO] Spark Project Parent POM ........................... SUCCESS [  9.048 s]
# [INFO] Spark Launcher Project ............................. SUCCESS [ 19.509 s]
# [INFO] Spark Project Networking ........................... SUCCESS [ 14.113 s]
# [INFO] Spark Project Shuffle Streaming Service ............ SUCCESS [  7.626 s]
# [INFO] Spark Project Core ................................. SUCCESS [05:46 min]
# [INFO] Spark Project Bagel ................................ SUCCESS [ 33.517 s]
# [INFO] Spark Project GraphX ............................... SUCCESS [01:45 min]
# [INFO] Spark Project Streaming ............................ SUCCESS [02:35 min]
# [INFO] Spark Project Catalyst ............................. SUCCESS [02:38 min]
# [INFO] Spark Project SQL .................................. SUCCESS [03:40 min]
# [INFO] Spark Project ML Library ........................... SUCCESS [03:46 min]
# [INFO] Spark Project Tools ................................ SUCCESS [ 19.095 s]
# [INFO] Spark Project Hive ................................. SUCCESS [03:00 min]
# [INFO] Spark Project REPL ................................. SUCCESS [01:07 min]
# [INFO] Spark Project Assembly ............................. SUCCESS [02:12 min]
# [INFO] Spark Project External Twitter ..................... SUCCESS [ 26.990 s]
# [INFO] Spark Project External Flume Sink .................. SUCCESS [ 41.008 s]
# [INFO] Spark Project External Flume ....................... SUCCESS [ 42.961 s]
# [INFO] Spark Project External MQTT ........................ SUCCESS [ 41.138 s]
# [INFO] Spark Project External ZeroMQ ...................... SUCCESS [ 27.237 s]
# [INFO] Spark Project External Kafka ....................... SUCCESS [01:04 min]
# [INFO] Spark Project Examples ............................. SUCCESS [03:53 min]
# [INFO] Spark Project External Kafka Assembly .............. SUCCESS [ 41.333 s]
# [INFO] ------------------------------------------------------------------------
# [INFO] BUILD SUCCESS
# [INFO] ------------------------------------------------------------------------
# [INFO] Total time: 36:57 min
# [INFO] Finished at: 2015-03-21T02:19:07+01:00
# [INFO] Final Memory: 83M/1292M
# [INFO] ------------------------------------------------------------------------
# Based on: https://github.com/databricks/spark-csv
# As an example, load cars.csv from github into Apache Spark using pyspark and databricks package
# com.databricks:spark-csv
cd ~/spark
# first clean up any previously downloaded files:
rm cars.csv
rm spark-csv
wget --no-check-certificate https://github.com/databricks/spark-csv/raw/master/src/test/resources/cars.csv
wget --no-check-certificate  https://github.com/databricks/spark-csv
groupId=`grep groupId spark-csv|cut -d":" -f2`
artifactId=`grep artifactId spark-csv|cut -d":" -f2`
version=`grep version spark-csv|tail -n 1|cut -d":" -f2`
# Use following command to run pyspark using four CPU cores on the local machine
# while also loading the spark-csv databricks package:
# source: https://spark.apache.org/docs/1.3.0/programming-guide.html
bin/pyspark -v --master local[4]  --packages `echo $groupId`:`echo $artifactId`:`echo $version`

# manually copy-paste following commands into the pyspark Terminal session:
from pyspark.sql import SQLContext
sqlContext = SQLContext(sc)
df = sqlContext.load(source = "com.databricks.spark.csv", header = "true",path = "cars.csv")
df.select("year", "model").show()
# output of last command should be similar to this:
# year model
# 2012 S    
# 1997 E350 
# Press CTRL-D to end the pyspark session
# useful link:  http://ramhiser.com/2015/02/01/configuring-ipython-notebook-support-for-pyspark/
