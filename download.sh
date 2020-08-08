#!/bin/bash

SCRIPT_DIR=`pwd`

source $SCRIPT_DIR/setenv

echo "Downloading derby and unzipping to ${DERBY_DB_HOME}"
rm db-derby-10.13.1.1-bin.zip
rm -rf ${DERBY_DB_HOME}
wget https://archive.apache.org/dist/db/derby/db-derby-10.13.1.1/db-derby-10.13.1.1-bin.zip
unzip -q db-derby-10.13.1.1-bin.zip
mkdir -p ${DERBY_HOME}
mv db-derby-10.13.1.1-bin ${DERBY_DB_HOME}
 
echo "Downloading ant and unzipping to ${ANT_HOME}"
rm apache-ant-1.9.15-bin.zip
rm -rf ${ANT_HOME}
wget http://www.trieuvan.com/apache//ant/binaries/apache-ant-1.9.15-bin.zip
unzip -q apache-ant-1.9.15-bin.zip 
mv apache-ant-1.9.15 ${ANT_HOME}
ant -version
